resource "aws_db_instance" "default" {
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  name                      = var.db_name
  username                  = var.user_name
  password                  = var.user_password
  parameter_group_name      = "default.mysql5.7"
  db_subnet_group_name      = "jpadjasek_subnet_group"
  skip_final_snapshot       = aaaa
}
