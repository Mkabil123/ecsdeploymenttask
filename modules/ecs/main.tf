locals {
  admin_container_name = "${var.env_name}-${var.app_name}-admin-app"
}

resource "aws_ecs_service" "admin_service" {
  name                   = "${var.env_name}-${var.app_name}-admin-service"
  cluster                = aws_ecs_cluster.ecs.id
  launch_type            = "FARGATE"
  task_definition        = aws_ecs_task_definition.admin_task_definition.arn
  desired_count          = 1
  enable_execute_command = true
  wait_for_steady_state  = false

  network_configuration {
    security_groups  = var.ecs_cluster_security_groups
    subnets          = var.ecs_cluster_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.admin_tg_arn
    container_name   = local.admin_container_name
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }

  depends_on = [
    aws_ecs_task_definition.admin_task_definition
  ]
}

resource "aws_ecs_task_definition" "admin_task_definition" {
  family                = "${var.env_name}-${var.app_name}-admin-task"
  container_definitions = <<DEFINITION
  [
    {
      "name": "${local.admin_container_name}",
      "image": "${var.admin_ecr_url}",
      "essential": true,
      "cpu": 0,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80,
          "protocol": "tcp"
        }
      ],
      "environment": [
        {"name": "S3_BUCKET_NAME", "value": "${var.storage_bucket_name}"},
        {"name": "AWS_REGION", "value": "${var.region}"},
        {"name": "RDS_HOSTNAME", "value": "${var.db_host}"},
        {"name": "RDS_PORT", "value": "${var.db_port}"},
        {"name": "RDS_DB_NAME", "value": "${var.database_name}"}
      ],
       "secrets": [
              {
                "name": "DB_CREDENTIALS",
                "valueFrom": "${var.db_secret_arn}"
              }
            ],
      "mountPoints": [],
      "volumesFrom": [],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.admin_laravel_log_group.name}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "admin"
        }
      }
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_cpu
  memory                   = var.ecs_memory
  task_role_arn            = var.ecs_task_execution_role
  execution_role_arn       = var.ecs_task_execution_role
}

resource "aws_cloudwatch_log_group" "admin_laravel_log_group" {
  name              = "/ecs/admin-app"
  retention_in_days = 30
}


