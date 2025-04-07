variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}