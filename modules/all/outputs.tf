output "subnet_group_name" {
  description = "The subnet group name"
  value       = aws_db_subnet_group.jpadjasek_subnet_group.id
}

output "security_group_id" {
  description = "The subnet group name"
  value       = aws_security_group.jpadjasek-security-group.id
}

output "subnet_id_1" {
  description = "The subnet group name"
  value       = aws_subnet.jpadjasek_subnet_public_AZ1.id
}

output "subnet_id_2" {
  description = "The subnet group name"
  value       = aws_subnet.jpadjasek_subnet_public_AZ2.id
}
