locals {
  full_project_name         = "${var.project_name}-${var.stage}"
  db_name                   = "${format("jpadjasekTerraformRDS%s", var.stage)}"
  db_replica_name           = "${format("jpadjasekTerraformRDSReplica%s", var.stage)}"
  db_identifier             = "${format("%s-rds-master", local.full_project_name)}"
  db_replica_identifier     = "${format("%s-rds-replica", local.full_project_name)}"
}

resource "aws_db_instance" "master" {
  identifier           = local.db_identifier
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  availability_zone    = "eu-west-2a"
  engine_version       = "5.7.22"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  username             = var.user_name
  password             = var.user_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = var.db_subnet_group_name
  backup_retention_period = 35
}

############
# Replica DB
############

resource "aws_db_instance" "replica" {
  identifier           = local.db_replica_identifier
  allocated_storage    = 20
  replicate_source_db  = aws_db_instance.master.id
  availability_zone    = "eu-west-2b"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.22"
  instance_class       = "db.t2.micro"
  name                 = local.db_replica_name
  username             = var.user_name
  password             = var.user_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
