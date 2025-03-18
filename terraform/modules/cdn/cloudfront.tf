resource "aws_cloudfront_distribution" "sub_domains" {
  for_each = { for sub_domain in var.sub_domains : sub_domain.name => sub_domain }
  aliases         = ["${each.value.name}.${var.domain}"]
  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods = [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT",
    ]
    cached_methods = [
      "GET",
      "HEAD",
    ]
    compress               = true
    smooth_streaming       = false
    target_origin_id       = "${each.value.name}.origin.${var.domain}"
    trusted_key_groups     = []
    trusted_signers        = []
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      headers      = ["*"]
      query_string = true

      cookies {
        forward           = "all"
        whitelisted_names = []
      }
    }
  }

  origin {
    domain_name = "${each.value.name}.origin.${var.domain}"
    origin_id   = "${each.value.name}.origin.${var.domain}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = [
        "TLSv1.2",
      ]
    }
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.certificate_arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}
