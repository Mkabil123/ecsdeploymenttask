module "bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.env_name}-bastion-sg"
  description = "Security group for ${var.env_name}-bastion-sg"
  vpc_id      = var.vpc_id

  egress_with_ipv6_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "::/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all inbound traffic"
    }
  ]

  tags = var.common_tags
}


module "app_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.env_name}-app-sg"
  description = "Security group for ${var.env_name}-app-sg"
  vpc_id      = var.vpc_id
  depends_on  = [module.bastion_sg]
  egress_with_ipv6_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "::/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      source_security_group_id = module.loadbalancer_sg.security_group_id
      description              = "Load balancer security group"
    },
    {
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      source_security_group_id = module.loadbalancer_sg.security_group_id
      description              = "Load balancer security group"
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      source_security_group_id = module.bastion_sg.security_group_id
      description              = "Bastion security group"
    },
  ]

  tags = var.common_tags
}


module "rds_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.env_name}-rds-sg"
  description = "Security group for ${var.env_name}-rds-sg"
  vpc_id      = var.vpc_id

  egress_with_ipv6_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "::/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr
      description = "VPC CIDR"
    },
  ]

  tags = var.common_tags
}


module "loadbalancer_sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${var.env_name}-loadbalancer_sg"
  description = "Security group for ${var.env_name}-loadbalancer_sg"
  vpc_id      = var.vpc_id

  egress_with_ipv6_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "::/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = var.common_tags
}

