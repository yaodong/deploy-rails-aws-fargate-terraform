variable "product" {
  description = "Product name"
  type        = string
  default     = "later"
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
  type = string
}

variable "vpc_private_subnet_ids" {
  type = list(string)
}

variable "secret_arn" {
  type = string
}

variable "ecs_cluster_id" {
  type = string
}

variable "ecs_desired_count" {
  description = "Number of docker containers to run"
  type        = number
  default     = 2
}

variable "ecs_security_group_id" {
  type = string
}

variable "app_security_group_id" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "docker_image_tag" {
  type    = string
  default = "latest"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "app_target_group_arn" {
  type = string
}

variable "database_endpoint" {
  type = string
}
