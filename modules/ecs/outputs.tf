output "ecs_admin_service_name" {
  value = aws_ecs_service.admin_service.name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs.name
}
