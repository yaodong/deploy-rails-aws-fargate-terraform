variable "product" {
  description = "Product name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region name"
  type        = string
  default     = "us-west-2"
}

variable "vpc_zones" {
  type    = list(string)
  default = ["usw2-az1", "usw2-az2"]
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_public_subnet_cidr_blocks" {
  type    = list(string)
  default = [
    "10.0.0.0/20", # cidrsubnet("10.0.0.0/16", 4, 0)
    "10.0.48.0/20", # cidrsubnet("10.0.0.0/16", 4, 2)
  ]
}

variable "vpc_private_subnet_cidr_blocks" {
  type    = list(string)
  default = [
    "10.0.16.0/20", # cidrsubnet("10.0.0.0/16", 4, 1)
    "10.0.64.0/20", # cidrsubnet("10.0.0.0/16", 4, 3)
  ]
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}
