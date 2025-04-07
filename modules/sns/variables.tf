variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}
variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "app_name" {
  description = "App name"
  type        = string
}

# Define a list of email addresses
variable "alert_email_addresses" {
  type = list(string)
}