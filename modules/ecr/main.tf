module "admin_ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name                 = "${var.env_name}-${var.app_name}-admin"
  repository_image_tag_mutability = "MUTABLE"
  # repository_read_write_access_arns = [var.ecr_iam_arn]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = var.common_tags
}

resource "null_resource" "ecr_login" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${module.admin_ecr.repository_url}"
  }
}

resource "null_resource" "pull_image" {
  provisioner "local-exec" {
    command = "docker pull nginx:latest"
  }
}

resource "null_resource" "tag_image_admin" {
  provisioner "local-exec" {
    command = "docker tag nginx:latest ${module.admin_ecr.repository_url}:latest"
  }
  depends_on = [
    null_resource.pull_image
  ]
}

resource "null_resource" "push_image_admin" {
  provisioner "local-exec" {
    command = "docker push ${module.admin_ecr.repository_url}:latest"
  }
  depends_on = [null_resource.tag_image_admin]
}
