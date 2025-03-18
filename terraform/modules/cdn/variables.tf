variable "domain" { type = string }
variable "certificate_arn" { type = string }
variable "sub_domains" { type = list(object({ name = string, records = list(string) })) }
