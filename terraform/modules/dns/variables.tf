variable "domain" { type = string }
variable "dns_records" { type = list(object({ type = string, name = string, ttl = number, proxied = bool, records = list(string) })) }
variable "sub_domains" { type = list(object({ name = string, records = list(string) })) }
