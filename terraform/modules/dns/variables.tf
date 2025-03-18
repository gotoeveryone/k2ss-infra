variable "domain" { type = string }
variable "dns_records" { type = list(object({ type = string, name = string, ttl = number, records = list(string) })) }
variable "sub_domains" { type = list(object({ name = string, records = list(string) })) }
variable "cdn_distibutions" { type = map(object({ hosted_zone_id = string, domain_name = string })) }
