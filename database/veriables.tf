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

variable "vpc_private_subnet_ids" {
  type = list(string)
}

variable "vpc_security_group_id" {
  type = string
}

variable "secret_arn" {
  type = string
}

variable "availability_zone" {
  type    = string
  default = "us-west-2a"
}

variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "14.2"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 10
}

variable "backup_retention_period" {
  type        = number
  description = "The days to retain backups for"
  default     = 1
}
