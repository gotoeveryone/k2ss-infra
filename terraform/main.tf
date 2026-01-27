provider "aws" {
  region = var.region

  default_tags {
    tags = {
      System = var.app_name
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "base" {
  region       = var.region
  app_name     = var.app_name
  repository   = var.repository
  domain       = var.domain
  dns_records  = var.dns_records
  sub_domains  = var.sub_domains
  allow_ssh_ip = var.allow_ssh_ip
  source       = "./modules"
}
