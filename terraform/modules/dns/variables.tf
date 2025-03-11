variable "domain" { type = string }
variable "dns_records" { type = list(object({ type = string, name = string, ttl = number, records = list(string) })) }
