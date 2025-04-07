resource "aws_lb" "app_alb" {
  name                       = "${var.env_name}-app-alb"
  load_balancer_type         = "application"
  internal                   = false
  security_groups            = var.loadbalancer_security_groups
  subnets                    = var.loadbalancer_subnets
  enable_deletion_protection = false

  access_logs {
    bucket  = var.load_balancer_logs_s3_bucket_id
    prefix  = "appx"
    enabled = true
  }

  tags = var.common_tags
}

// admin listener
resource "aws_lb_listener" "app_alb_listener_443_admin" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.admin_tg.arn
  }

  tags = var.common_tags
}


///listener rules
resource "aws_lb_listener_rule" "admin_rule" {
  listener_arn = aws_lb_listener.app_alb_listener_443_admin.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.admin_tg.arn
  }

  condition {
    host_header {
      values = ["${var.admin_domain_name}.${var.domain_name}"]
    }
  }
}

