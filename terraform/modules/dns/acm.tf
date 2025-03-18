resource "aws_acm_certificate" "main" {
  domain_name       = var.domain
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain}",
    var.domain,
  ]
}

resource "aws_acm_certificate" "cloudfront" {
  domain_name       = var.domain
  validation_method = "DNS"
  provider          = aws.virginia

  subject_alternative_names = [
    "*.${var.domain}",
    var.domain,
  ]
}
