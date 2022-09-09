terraform {
  backend "remote" {
    organization = "__NAME__"

    workspaces {
      prefix = "database-"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "${lower(var.product)}-${lower(var.env)}"
}

data "aws_secretsmanager_secret_version" "this" {
  secret_id = var.secret_arn
}

locals {
  database_password = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string).DATABASE_PASSWORD
}
