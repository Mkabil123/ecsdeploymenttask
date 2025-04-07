variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

variable "zone_id" {
  description = "The Hosted Zone id"
  type        = string
}
