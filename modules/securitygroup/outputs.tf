output "rds_sg_id" {
  description = "RDS security group id"
  value       = module.rds_sg.security_group_id
}

output "app_sg_id" {
  description = "App security group id"
  value       = module.app_sg.security_group_id
}

output "loadbalancer_sg_id" {
  description = "Load balancer security group id"
  value       = module.loadbalancer_sg.security_group_id
}

output "bastion_sg_id" {
  description = "Bastion security group id"
  value       = module.bastion_sg.security_group_id

}




