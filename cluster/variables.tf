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

variable "secret_arn" {
  type = string
}
