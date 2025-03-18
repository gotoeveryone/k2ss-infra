variable "region" { default = "ap-northeast-1" }
variable "app_name" { default = "k2ss" }
variable "repository" { default = "gotoeveryone/k2ss-infra" }
variable "domain" { type = string }
variable "dns_records" { type = list(object({ type = string, name = string, ttl = number, records = list(string) })) }
variable "sub_domains" { type = list(object({ name = string, records = list(string) })) }
variable "allow_ssh_ip" { type = string }
