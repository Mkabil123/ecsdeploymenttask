variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "admin_tg_arn" {
  description = "Admin target group ARN"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}
variable "ecs_cluster_security_groups" {
  description = "ECS security groups"
  type        = any
}
variable "ecs_cluster_subnets" {
  description = "ECS cluster subnets"
  type        = any
}

variable "ecs_task_execution_role" {
  description = "ECS task execution role"
  type        = string
}

variable "ecs_task_role" {
  description = "ECS task role"
  type        = string
}

variable "db_secret_arn" {
  description = "List of secrets to pass to the container"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "admin_ecr_url" {
  description = "Admin image arn from ecr repository"
  type        = string
}

variable "ecs_cpu" {
  description = "ECS cpu configuration"
  type        = string
}

variable "ecs_memory" {
  description = "ECS memory configuration"
  type        = string
}

variable "storage_bucket_name" {
  description = "Storage bucket name"
  type        = string
}

variable "db_host" {
  description = "DB host"
  type        = string
}

variable "db_port" {
  description = "DB port"
  type        = string
}

variable "database_name" {
  description = "DB database"
  type        = string
}

