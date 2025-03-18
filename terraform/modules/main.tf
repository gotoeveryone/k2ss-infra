
module "cdn" {
  source                 = "./cdn"
  domain                = var.domain
  sub_domains = var.sub_domains
  certificate_arn        = module.dns.cdn_certificate_arn
}

module "dns" {
  domain      = var.domain
  dns_records = var.dns_records
  sub_domains = var.sub_domains
  cdn_distibutions = module.cdn.distibutions
  source      = "./dns"
}

module "identity" {
  app_name                 = var.app_name
  repository               = var.repository
  internal_resource_bucket = module.storage.internal_resource_bucket
  source                   = "./identity"
}

module "server" {
  region       = var.region
  app_name       = var.app_name
  allow_ssh_ip = var.allow_ssh_ip
  source       = "./server"
}

module "storage" {
  app_name = var.app_name
  source   = "./storage"
}
