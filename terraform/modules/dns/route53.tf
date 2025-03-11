resource "aws_route53_zone" "main" {
  name = var.domain
}

resource "aws_route53_record" "main" {
  for_each = {
    for dns_record in var.dns_records : "${dns_record.name}_${dns_record.type}" => {
      name    = dns_record.name
      type    = dns_record.type
      ttl     = dns_record.ttl
      records = dns_record.records
    }
  }

  zone_id = aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}

resource "aws_route53_record" "certificate" {
  for_each = {
    for dvo in setunion(aws_acm_certificate.main.domain_validation_options) : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  zone_id         = aws_route53_zone.main.zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 300
  records         = [each.value.record]
}
