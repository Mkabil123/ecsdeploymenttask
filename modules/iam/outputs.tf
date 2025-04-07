output "ecs_task_execution_role_arn" {
  description = "ECS task execution role arn"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "jenkins_ecr_instance_profile_name" {
  description = "ECR "
  value       = aws_iam_instance_profile.jenkins_ecr_instance_profile.name
}