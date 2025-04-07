variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "availability_zones" {
  description = "The availability zones for the subnets"
  type        = list(string)
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC"
  default     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
  default     = ["10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enabe NAT gateway"
}

variable "single_nat_gateway" {
  type        = bool
  description = "Enabe single NAT gateway"
}

variable "public_subnet_ipv6_prefixes" {
  type        = list(string)
  description = "Prefix to ipv6"
  default     = [0, 1, 2]
}

variable "private_subnet_ipv6_prefixes" {
  type        = list(string)
  description = "Prefix to ipv6"
  default     = [3, 4, 5]
}

variable "region_name" {
  type        = string
  description = "AWS region name"
}


variable "one_nat_gateway_per_az" {
  type        = bool
  description = "Attach one NAT per Az"
  default     = false
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags"
}
