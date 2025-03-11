terraform {
  required_version = "~> 1.11.0"

  backend "remote" {
    organization = "k2ss"

    workspaces {
      name = "k2ss-infra"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.4.0"
    }
  }
}
