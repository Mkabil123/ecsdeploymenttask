module "db" {
  source = "terraform-aws-modules/rds-aurora/aws"

  database_name  = "${var.env_name}${var.app_name}"
  name           = "${var.env_name}${var.app_name}-db"
  engine         = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_type
  instances = { 1 = {
    database_name = "${var.database_name}"
  } }
  port                                 = var.db_port
  create_db_subnet_group               = true
  deletion_protection                  = true
  db_subnet_group_name                 = "${var.env_name}${var.app_name}-db-subnet-group"
  manage_master_user_password          = true
  master_username                      = var.db_username
  vpc_id                               = var.vpc_id
  vpc_security_group_ids               = var.rds_sg_id
  apply_immediately                    = true
  skip_final_snapshot                  = true
  backup_retention_period              = var.db_backup_retention_period
  autoscaling_enabled                  = true
  autoscaling_min_capacity             = var.db_autoscaling_min_capacity
  autoscaling_max_capacity             = var.db_autoscaling_max_capacity
  autoscaling_policy_name              = "${var.env_name}${var.app_name}-db-asg-policy"
  availability_zones                   = var.availability_zones
  preferred_backup_window              = "22:00-23:00"
  storage_encrypted                    = true
  subnets                              = var.rds_subnets
  manage_master_user_password_rotation = false

  tags = var.common_tags
}
