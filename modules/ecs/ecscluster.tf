resource "aws_ecs_cluster" "ecs" {
  name = "${var.env_name}-${var.app_name}-cluster"

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.ecs.arn
      logging    = "OVERRIDE"
      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs.name
      }
    }
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "${var.env_name}-${var.app_name}-cluster-logs"
  retention_in_days = 365
}

resource "aws_kms_key" "ecs" {
  description             = "ECS KMS key"
  deletion_window_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs" {
  cluster_name       = aws_ecs_cluster.ecs.name
  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 0
    weight            = 100
    capacity_provider = "FARGATE"
  }
}