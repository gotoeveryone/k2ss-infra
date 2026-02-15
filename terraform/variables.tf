variable "region" { default = "ap-northeast-1" }
variable "app_name" { default = "k2ss" }
variable "repository" { default = "gotoeveryone/k2ss-infra" }
variable "domain" { type = string }
variable "dns_records" { type = list(object({ type = string, name = string, ttl = number, proxied = bool, records = list(string) })) }
variable "sub_domains" { type = list(object({ name = string, records = list(string) })) }
variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}
variable "cloudflare_zone_id" {
  type = string
}
