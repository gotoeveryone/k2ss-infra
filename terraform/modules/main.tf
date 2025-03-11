module "dns" {
  domain      = var.domain
  dns_records = var.dns_records
  source      = "./dns"
}

module "identity" {
  app_name                 = var.app_name
  repository               = var.repository
  internal_resource_bucket = module.storage.internal_resource_bucket
  source                   = "./identity"
}

module "storage" {
  app_name = var.app_name
  source   = "./storage"
}
