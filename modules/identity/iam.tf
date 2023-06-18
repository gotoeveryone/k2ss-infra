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
    aws_iam_policy.ci_policy.arn,
  ]
}

resource "aws_iam_policy" "ci_policy" {
  name        = "${var.app_name}-ci-policy"
  description = "for GitHub Actions OIDC"

  policy = data.aws_iam_policy_document.ci_policy.json
}

data "aws_iam_policy_document" "ci_policy" {
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
