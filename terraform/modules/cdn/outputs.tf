output "distibutions" {
  value = {
    for key, sub_domain in aws_cloudfront_distribution.sub_domains : key => {
      hosted_zone_id = sub_domain.hosted_zone_id
      domain_name    = sub_domain.domain_name
    }
  }
}
