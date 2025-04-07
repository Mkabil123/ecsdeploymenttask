variable "common_tags" {
  description = "Common tags for resources"
  type        = map(string)
}

variable "domain_name" {
  description = "The domain name for the application"
  type        = string
}

variable "admin_domain_name" {
  description = "The sub domain name for the admin application"
  type        = string
}

variable "alb_dns_name" {
  description = "The dns name of application load balancer"
  type        = string
}

variable "alb_zone_id" {
  description = "The id of application load balancer zone"
  type        = string
}
