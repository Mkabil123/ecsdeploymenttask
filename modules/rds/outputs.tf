//host name writers
output "db_cluster_endpoint" {
  description = "Writer endpoint of database cluster"
  value       = module.db.cluster_endpoint
}
//host name readers
output "db_reader_host" {
  description = "Reader endpoint of database cluster"
  value       = module.db.cluster_reader_endpoint
}

output "db_user_secret" {
  description = "Database cluster user secret"
  value       = module.db.cluster_master_user_secret
}

output "rds_cluster_id" {
  description = "Database cluster instance id"
  value       = module.db.cluster_id
}