terraform {
  backend "remote" {
    organization = "__NAME__"

    workspaces {
      prefix = "networking-"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "${lower(var.product)}-${lower(var.env)}"
}
