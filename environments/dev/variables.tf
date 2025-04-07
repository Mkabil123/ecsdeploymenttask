variable "region" {
  type        = string
  description = "AWS region"
}

variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "availability_zones" {
  description = "VPC availability zones"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway?"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Enable single NAT gateway?"
  type        = bool
  default     = true
}

variable "bastion_instance_type" {
  description = "Bastion instance type"
  type        = string
}

variable "domain_name" {
  description = "Primary domain name for the application"
  type        = string
}

variable "common_tags" {
  description = "Commong tags"
  type        = map(string)
}

variable "db_engine" {
  description = "The name of the database engine"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_instance_type" {
  description = "Database instance type"
  type        = string
}

variable "db_username" {
  description = "database username"
  type        = string
}

variable "db_port" {
  description = "Database port number"
  type        = string
}

variable "db_backup_retention_period" {
  description = "Back up retension period of database snapshot"
  type        = string
}

variable "db_autoscaling_min_capacity" {
  description = "Auto Scaling of database minimum instance"
  type        = number
}

variable "db_autoscaling_max_capacity" {
  description = "Auto scaling of database maximum instance"
  type        = number
}

variable "ami_instance_type" {
  description = "AMI server instance type"
  type        = string
}

variable "ami_name" {
  description = "Ami name"
  type        = list(string)
}

variable "autoscalling_min_size" {
  description = "Auto scalling min size"
  type        = number
}

variable "autoscalling_max_size" {
  description = "Auto scalling max size"
  type        = number
}

variable "autoscalling_desired_capacity" {
  description = "Auto scalling desired capacity"
  type        = string
}

variable "admin_domain_name" {
  description = "Admin domain name"
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

variable "alert_email_addresses" {
  type = list(string)
}

variable "elb_account_id" {
  description = "The ID of the AWS account for Elastic Load Balancing for your Region"
  type        = string
}

variable "database_name" {
  description = "Database name"
  type        = string

}
