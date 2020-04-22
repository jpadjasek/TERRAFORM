output "rds_id" {
  description = "The RDS ID"
  value       = aws_db_instance.master.id
}

output "rds_replica_id" {
  description = "The RDS read replica id"
  value       = aws_db_instance.master.id
}
