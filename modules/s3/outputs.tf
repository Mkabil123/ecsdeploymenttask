output "storage_s3_bucket_id" {
  description = "The id of the KYC S3 bucket"
  value       = module.storage_s3_bucket.s3_bucket_id
}

output "storage_bucket_arn" {
  description = "The ARN of the KYC S3 bucket"
  value       = module.storage_s3_bucket.s3_bucket_arn
}

output "log_s3_bucket_id" {
  description = "The id of the log S3 bucket"
  value       = module.app_logs_s3_bucket.s3_bucket_id
}

output "app_log_bucket_arn" {
  description = "The ARN of the log S3 bucket"
  value       = module.app_logs_s3_bucket.s3_bucket_arn
}

output "load_balancer_logs_s3_bucket_id" {
  description = "The id of the load balancer logs S3 bucket"
  value       = module.load_balancer_logs_s3_bucket.s3_bucket_id
}

output "load_balancer_logs_bucket_arn" {
  description = "The ARN of the load balancer logs S3 bucket"
  value       = module.load_balancer_logs_s3_bucket.s3_bucket_arn
}


