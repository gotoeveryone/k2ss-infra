resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_iam_policy_document" "github_actions_policy" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity",
    ]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.github_actions.arn
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.repository}:*",
      ]
    }
  }
}

resource "aws_iam_role" "ci_role" {
  name                  = "${var.app_name}-ci-role"
  assume_role_policy    = data.aws_iam_policy_document.github_actions_policy.json
  description           = "for GitHub Actions OIDC"
  force_detach_policies = false
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/IAMReadOnlyAccess",
    aws_iam_policy.ci_policy.arn,
  ]
}

resource "aws_iam_policy" "ci_policy" {
  name        = "${var.app_name}-ci-policy"
  description = "for GitHub Actions OIDC"

  policy = data.aws_iam_policy_document.ci_policy.json
}

data "aws_iam_policy_document" "ci_policy" {
  # S3
  statement {
    # 細かく制御するとキリが無いので、Get/List は全許可する
    # tfsec:ignore:aws-iam-no-policy-wildcards
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      "arn:aws:s3:::${var.internal_resource_bucket}",
      "arn:aws:s3:::${var.internal_resource_bucket}/*",
    ]
  }
}

resource "aws_iam_group" "internal_resource_controller" {
  name = "${var.app_name}-internal-resource-controller"
  path = "/"
}

resource "aws_iam_group_policy_attachment" "internal_resource_controller" {
  group      = aws_iam_group.internal_resource_controller.name
  policy_arn = aws_iam_policy.internal_resource_controller_policy.arn
}

resource "aws_iam_policy" "internal_resource_controller_policy" {
  name        = "${aws_iam_group.internal_resource_controller.name}-policy"
  description = "for Internal Resource Controller"

  policy = data.aws_iam_policy_document.internal_resource_controller_policy.json
}

data "aws_iam_policy_document" "internal_resource_controller_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]

    resources = [
      "arn:aws:s3:::${var.internal_resource_bucket}/*",
    ]
  }
}
