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

variable "domain_name" {
  description = "Domain name for sending email"
  type        = string
}

variable "route53_zone_id" {
  type = string
}
