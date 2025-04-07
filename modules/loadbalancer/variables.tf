variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "loadbalancer_security_groups" {
  description = "Load balancer security group ids"
  type        = list(string)
}

variable "loadbalancer_subnets" {
  description = "VPC subnets group ids for loadbalancer"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "certificate_arn" {
  description = "Certificate arn"
  type        = string
}

variable "admin_domain_name" {
  description = "Admin domain name"
  type        = string
}

variable "load_balancer_logs_s3_bucket_id" {
  description = "Loadbalancer log s3 bucket id"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}
