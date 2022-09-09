terraform {
  backend "remote" {
    organization = "__NAME__"

    workspaces {
      prefix = "bastion-"
    }
  }
}
provider "aws" {
  region  = var.region
  profile = format("%s-%s", var.product, var.env)
}
