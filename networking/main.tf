terraform {
  backend "remote" {
    organization = "later"

    workspaces {
      prefix = "networking-"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "${lower(var.product)}-${lower(var.env)}"
}
