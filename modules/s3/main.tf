module "storage_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                   = "${var.env_name}-${var.app_name}-storage"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  block_public_policy      = false
  tags                     = merge(var.common_tags, { Name = "${var.env_name}-storage" })
}



resource "aws_s3_bucket_cors_configuration" "storage_s3_bucket_cors" {
  bucket = module.storage_s3_bucket.s3_bucket_id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}



resource "aws_s3_bucket_policy" "storage_s3_bucket_policy" {
  bucket = module.storage_s3_bucket.s3_bucket_id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.env_name}-${var.app_name}-storage",
                "arn:aws:s3:::${var.env_name}-${var.app_name}-storage/*"
            ]
        }
    ]
}
EOF
}


data "aws_caller_identity" "current" {}

module "load_balancer_logs_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                   = "${var.env_name}-${var.app_name}-alb-logs"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  block_public_policy      = false
  tags                     = merge(var.common_tags, { Name = "${var.env_name}-alb-logs" })
}

resource "aws_s3_bucket_policy" "alb_logs_s3_bucket_policy" {
  bucket = module.load_balancer_logs_s3_bucket.s3_bucket_id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                  "AWS": "arn:aws:iam::${var.elb_account_id}:root"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.env_name}-${var.app_name}-alb-logs/*"
            ]
        }
    ]
}
EOF
}





module "app_logs_s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                   = "${var.env_name}-${var.app_name}-app-logs"
  acl                      = "private"
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  block_public_policy      = false
  tags                     = merge(var.common_tags, { Name = "${var.env_name}-app-logs" })
}


resource "aws_s3_bucket_cors_configuration" "app_logs_s3_bucket" {
  bucket = module.app_logs_s3_bucket.s3_bucket_id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}




resource "aws_s3_bucket_policy" "app_logs_s3_bucket_policy" {
  bucket = module.app_logs_s3_bucket.s3_bucket_id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.env_name}-${var.app_name}-app-logs",
                "arn:aws:s3:::${var.env_name}-${var.app_name}-app-logs/*"
            ]
        }
    ]
}
EOF
}

