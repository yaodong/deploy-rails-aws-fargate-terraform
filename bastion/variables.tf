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

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  description = "One public subset ID to place the bastion server"
  type        = string
}

variable "security_group_id" {
  type = string
}

variable "allowed_hosts" {
  description = "CIDR blocks of trusted networks"
  type        = list(string)
}

variable "internal_networks" {
  type        = list(string)
  description = "Internal network CIDR blocks."
  default     = ["10.0.0.0/16"]
}

variable "disk_size" {
  description = "The size of the root volume in gigabytes."
  default     = 8
}
