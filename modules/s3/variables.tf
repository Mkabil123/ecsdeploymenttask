variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
}

variable "elb_account_id" {
  description = "The ID of the AWS account for Elastic Load Balancing for your Region"
  type        = string
}
