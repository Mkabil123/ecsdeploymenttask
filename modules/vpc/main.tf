module "app_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                         = "${var.env_name}-vpc"
  cidr                         = var.vpc_cidr
  azs                          = var.availability_zones
  private_subnets              = var.vpc_private_subnets
  public_subnets               = var.vpc_public_subnets
  enable_nat_gateway           = var.enable_nat_gateway
  enable_ipv6                  = true
  single_nat_gateway           = var.single_nat_gateway
  public_subnet_ipv6_prefixes  = var.public_subnet_ipv6_prefixes
  private_subnet_ipv6_prefixes = var.private_subnet_ipv6_prefixes
  one_nat_gateway_per_az       = var.one_nat_gateway_per_az

  tags = var.common_tags
}

