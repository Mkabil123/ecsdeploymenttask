resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.env_name}-${var.app_name}-s3-access-policy"
  description = "IAM policy for accessing S3 buckets"

  # Define the policy document
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.env_name}-${var.app_name}-kyc",
          "arn:aws:s3:::${var.env_name}-${var.app_name}-documents",
          # "arn:aws:s3:::${var.env_name}-${var.app_name}-app-logs",
          # "arn:aws:s3:::${var.env_name}-${var.app_name}-alb-logs",
        ]
      }
    ]
  })
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.env_name}-${var.app_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  name       = "${var.env_name}-${var.app_name}-ecs-task-execution-role-policy-attachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "ecs_task_s3_access_policy" {
  name        = "${var.env_name}-${var.app_name}-ecs-task-s3-access-policy"
  description = "IAM policy for ECS task to access S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.env_name}-${var.app_name}-kyc",
          "arn:aws:s3:::${var.env_name}-${var.app_name}-documents"
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ecs_task_s3_policy_attachment" {
  name       = "${var.env_name}-${var.app_name}-ecs-task-s3-policy-attachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = aws_iam_policy.ecs_task_s3_access_policy.arn
}

resource "aws_iam_role" "jenkins_ecr_role" {
  name = "${var.env_name}-${var.app_name}-jenkins-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_access_policy" {
  name        = "${var.env_name}-${var.app_name}-ecr-access-policy"
  description = "IAM policy for accessing ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:CreateRepository",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy",
          "ecr:GetAuthorizationToken",
          "ecs:UpdateService",
          "ecs:DescribeServices",
          "ecs:ListClusters",
          "ecs:DescribeTaskDefinition",
          "ecs:RunTask",
          "ecs:StopTask",
          "ecs:ListTasks",
          "ecs:RegisterTaskDefinition",
          "ecs:DeregisterTaskDefinition",
          "ecs:ListTaskDefinitions"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "jenkins_ecr_policy_attachment" {
  name       = "${var.env_name}-${var.app_name}-jenkins-ecr-policy-attachment"
  roles      = [aws_iam_role.jenkins_ecr_role.name]
  policy_arn = aws_iam_policy.ecr_access_policy.arn
}

resource "aws_iam_instance_profile" "jenkins_ecr_instance_profile" {
  name = "${var.env_name}-${var.app_name}-jenkins-ecr-instance-profile"
  role = aws_iam_role.jenkins_ecr_role.name
}

resource "aws_iam_policy" "ecs_task_access_policy" {
  name        = "${var.env_name}-${var.app_name}-ecs-task-access-policy"
  description = "IAM policy for accessing S3 buckets"

  # Define the policy document
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings",
          "kms:Decrypt",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup",
          "ssm:ListTagsForResource",
          "ssm:GetParameters",
          "ssm:GetParameterHistory",
          "ssm:GetParameter",
          "ssm:DescribeParameters",
          "secretsmanager:GetSecretValue",
          "cognito-identity:*",
          "cognito-idp:*",
          "cognito-sync:*",
          "iam:ListRoles",
          "iam:ListOpenIdConnectProviders",
          "iam:GetRole",
          "iam:ListSAMLProviders",
          "iam:GetSAMLProvider",
          "kinesis:ListStreams",
          "lambda:GetPolicy",
          "lambda:ListFunctions",
          "lambda:InvokeFunction",
          "sns:GetSMSSandboxAccountStatus",
          "sns:ListPlatformApplications",
          "ses:ListIdentities",
          "ses:GetIdentityVerificationAttributes",
          "mobiletargeting:GetApps",
          "acm:ListCertificates"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ecs_task_access_policy_attachment" {
  name       = "${var.env_name}-${var.app_name}-ecs-task-access-policy-attachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = aws_iam_policy.ecs_task_access_policy.arn
}
