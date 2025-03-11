variable "region" { type = string }
variable "app_name" { type = string }
variable "repository" { type = string }
variable "domain" { type = string }
variable "dns_records" { type = list(object({ type = string, name = string, ttl = number, records = list(string) })) }
