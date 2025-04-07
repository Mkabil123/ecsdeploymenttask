variable "vpc_id" {
  description = "The VPC id"
  type        = string
}

variable "rds_sg_id" {
  description = "The Rds Security Group Id"
  type        = list(string)
}

variable "db_engine" {
  description = "The name of the database engine"
  type        = string
}

variable "db_engine_version" {
  description = "The version of database engine"
  type        = string
}

variable "db_instance_type" {
  description = "The database instance type"
  type        = string
}

variable "db_username" {
  description = "The database username"
  type        = string
}

variable "availability_zones" {
  description = "The availability zones for the RDS"
  type        = list(string)
}

variable "rds_subnets" {
  description = "The vpc subnets for RDS"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "db_port" {
  description = "Database port"
  type        = string
}

variable "db_backup_retention_period" {
  description = "Back up retension period of database snapshot"
  type        = string
}

variable "db_autoscaling_min_capacity" {
  description = "Auto scaling of database minimum instance"
  type        = number
}

variable "db_autoscaling_max_capacity" {
  description = "Auto scaling of database max instance"
  type        = number
}

variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "app_name" {
  description = "App name"
  type        = string
}

variable "database_name" {
  description = "Database name"
  type        = string

}
