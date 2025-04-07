module "app_vpc" {
  source = "../../modules/vpc"

  enable_nat_gateway = var.enable_nat_gateway
  region_name        = var.region
  single_nat_gateway = var.single_nat_gateway
  availability_zones = var.availability_zones
  env_name           = var.env_name
  common_tags        = var.common_tags
}

module "security_groups" {
  source = "../../modules/securitygroup"

  vpc_id      = module.app_vpc.vpc_id
  vpc_cidr    = module.app_vpc.vpc_cidr
  common_tags = var.common_tags
  env_name    = var.env_name

  depends_on = [module.app_vpc]
}

module "iam" {
  source = "../../modules/iam"

  env_name = var.env_name
  app_name = var.app_name
}

module "s3" {
  source = "../../modules/s3"

  app_name       = var.app_name
  env_name       = var.env_name
  elb_account_id = var.elb_account_id
  common_tags    = var.common_tags

  depends_on = [module.iam]
}

module "aws_key_pair" {
  source = "../../modules/keypair"

  env_name = var.env_name
}

module "ec2" {
  source = "../../modules/ec2"

  bastion_instance_type = var.bastion_instance_type
  bastion_sgs           = [module.security_groups.bastion_sg_id]
  bastion_subnet_id     = module.app_vpc.public_subnet_ids[0]
  env_name              = var.env_name
  region                = var.region
  common_tags           = var.common_tags
}

module "rds" {
  source = "../../modules/rds"

  db_engine                   = var.db_engine
  db_engine_version           = var.db_engine_version
  db_instance_type            = var.db_instance_type
  db_username                 = var.db_username
  vpc_id                      = module.app_vpc.vpc_id
  rds_sg_id                   = [module.security_groups.rds_sg_id]
  env_name                    = var.env_name
  app_name                    = var.app_name
  database_name               = var.database_name
  availability_zones          = var.availability_zones
  rds_subnets                 = module.app_vpc.private_subnet_ids
  db_port                     = var.db_port
  db_backup_retention_period  = var.db_backup_retention_period
  db_autoscaling_min_capacity = var.db_autoscaling_min_capacity
  db_autoscaling_max_capacity = var.db_autoscaling_max_capacity
  common_tags                 = var.common_tags
}

module "loadbalancer" {
  source = "../../modules/loadbalancer"

  env_name                        = var.env_name
  vpc_id                          = module.app_vpc.vpc_id
  loadbalancer_security_groups    = [module.security_groups.loadbalancer_sg_id]
  loadbalancer_subnets            = [module.app_vpc.public_subnet_ids[0], module.app_vpc.public_subnet_ids[1], module.app_vpc.public_subnet_ids[2]]
  admin_domain_name               = var.admin_domain_name
  load_balancer_logs_s3_bucket_id = module.s3.load_balancer_logs_s3_bucket_id
  common_tags                     = var.common_tags
  domain_name                     = var.domain_name
  certificate_arn                 = ""
  #certificate_arn            = module.ssl_certificate.ssl_certificate_arn
}

module "ecr" {
  source = "../../modules/ecr"

  env_name    = var.env_name
  app_name    = var.app_name
  region      = var.region
  common_tags = var.common_tags
}

module "ecs" {
  source = "../../modules/ecs"

  env_name                    = var.env_name
  app_name                    = var.app_name
  vpc_id                      = module.app_vpc.vpc_id
  ecs_cluster_security_groups = [module.security_groups.app_sg_id]
  ecs_cluster_subnets         = [module.app_vpc.private_subnet_ids[0], module.app_vpc.private_subnet_ids[1], module.app_vpc.private_subnet_ids[2]]
  admin_tg_arn                = module.loadbalancer.admin_tg_arn
  ecs_task_execution_role     = module.iam.ecs_task_execution_role_arn
  ecs_task_role               = module.iam.ecs_task_execution_role_arn
  admin_ecr_url               = module.ecr.admin_ecr_url
  ecs_cpu                     = var.ecs_cpu
  ecs_memory                  = var.ecs_memory
  region                      = var.region
  db_port                     = var.db_port
  database_name               = var.database_name
  db_host                     = module.rds.db_cluster_endpoint
  db_secret_arn               = lookup(module.rds.db_user_secret[0], "secret_arn", null)
  storage_bucket_name         = module.s3.storage_s3_bucket_id
  depends_on                  = [module.loadbalancer]
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  ecs_admin_service_name    = module.ecs.ecs_admin_service_name
  ecs_cluster_name          = module.ecs.ecs_cluster_name
  rds_cluster_id            = module.rds.rds_cluster_id
  app_name                  = var.app_name
  env_name                  = var.env_name
  email_alert_sns_topic_arn = module.sns.email_alert_sns_topic_arn
  common_tags               = var.common_tags
}

module "sns" {
  source = "../../modules/sns"

  app_name              = var.app_name
  env_name              = var.env_name
  alert_email_addresses = var.alert_email_addresses
  common_tags           = var.common_tags
}

module "route53" {
  source = "../../modules/route53"

  alb_dns_name      = module.loadbalancer.alb_dns_name
  admin_domain_name = var.admin_domain_name
  domain_name       = var.domain_name
  alb_zone_id       = module.loadbalancer.alb_zone_id
  common_tags       = var.common_tags
}

module "waf" {
  source = "../../modules/waf"

  app_name   = var.app_name
  env_name   = var.env_name
  aws_lb_arn = module.loadbalancer.load_balancer_arn

  depends_on = [module.loadbalancer]
}

module "ssl_certificate" {
  source = "../../modules/certificate"

  domain_name = var.domain_name
  zone_id     = module.route53.zone_id
  common_tags = var.common_tags
}

module "ses" {
  source = "../../modules/ses"

  zone_id     = module.route53.zone_id
  domain_name = var.domain_name
}
