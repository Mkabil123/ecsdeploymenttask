output "vpc_id" {
  description = "The id of the VPC"
  value       = module.app_vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC cidr blocks"
  value       = module.app_vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "The public subnets"
  value       = module.app_vpc.public_subnets
}

output "private_subnet_ids" {
  description = "The private subnets"
  value       = module.app_vpc.private_subnets
}