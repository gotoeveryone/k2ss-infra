provider "aws" {
  region = var.region

  default_tags {
    tags = {
      System = var.app_name
    }
  }
}

module "base" {
  region      = var.region
  app_name    = var.app_name
  repository  = var.repository
  domain      = var.domain
  dns_records = var.dns_records
  source      = "./modules"
}
