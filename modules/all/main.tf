locals {
  full_project_name   = "${var.project_name}-${var.stage}"
}

resource "aws_vpc" "jpadjasek-vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "${format("%s-vpc", local.full_project_name)}"
    Owner = "jpadjasek"
  }
}

resource "aws_subnet" "jpadjasek_subnet_public_AZ1" {
  vpc_id = aws_vpc.jpadjasek-vpc.id
  cidr_block = var.cidr_subnet
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone_1
  tags = {
    Owner = "jpadjasek"
    Name = "${format("%s-public-sub-AZ1", local.full_project_name)}"
  }
}

resource "aws_subnet" "jpadjasek_subnet_public_AZ2" {
  vpc_id = aws_vpc.jpadjasek-vpc.id
  cidr_block = var.cidr_subnet_2
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone_2
  tags = {
    Owner = "jpadjasek"
    Name = "${format("%s-public-sub-AZ2", local.full_project_name)}"
  }
}

resource "aws_security_group" "jpadjasek-security-group" {
  vpc_id = aws_vpc.jpadjasek-vpc.id
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Owner = "jpadjasek"
    Name = "${format("%s-security-group", local.full_project_name)}"
  }
}

resource "aws_instance" "jpadjasek-ec2-instance_AZ1" {
  ami           = "ami-01a6e31ac994bbc09"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jpadjasek-security-group.id]
  subnet_id = aws_subnet.jpadjasek_subnet_public_AZ1.id
  availability_zone = var.availability_zone_1
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Owner = "jpadjasek"
    Name = "${format("%s-ec2-AZ1", local.full_project_name)}"
    }
}
resource "aws_instance" "jpadjasek-ec2-instance_AZ2" {
  ami           = "ami-01a6e31ac994bbc09"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jpadjasek-security-group.id]
  subnet_id = aws_subnet.jpadjasek_subnet_public_AZ2.id
  availability_zone = var.availability_zone_2
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Owner = "jpadjasek"
    Name = "${format("%s-ec2-AZ2", local.full_project_name)}"
  }
}

resource "aws_db_subnet_group" "jpadjasek_subnet_group" {
  name = "jpadjasek_subnet_group"
  subnet_ids = [aws_subnet.jpadjasek_subnet_public_AZ2.id, aws_subnet.jpadjasek_subnet_public_AZ1.id]
}

resource "aws_db_instance" "default" {
  identifier           = "jpadjasek-rds-master"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  availability_zone    = "eu-west-2a"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  username             = var.user_name
  password             = var.user_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.jpadjasek_subnet_group.name
  backup_retention_period = 35
}

############
# Replica DB
############

resource "aws_db_instance" "replica" {
  identifier           = "jpadjasek-rds-replica"
  allocated_storage    = 20
  replicate_source_db  = aws_db_instance.default.id
  availability_zone    = "eu-west-2b"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = var.db_replica_name
  username             = var.user_name
  password             = var.user_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
