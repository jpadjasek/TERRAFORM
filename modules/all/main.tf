locals {
  full_project_name   = "${var.project_name}-${var.stage}"
}

resource "aws_vpc" "jpadjasek-vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_hostnames = "true"
  tags = {
    Name = "${format("%s-vpc", local.full_project_name)}"
    Owner = "jpadjasek"
  }
}

resource "aws_internet_gateway" "jpadjasek-internet-gateway" {
  vpc_id = aws_vpc.jpadjasek-vpc.id

  tags = {
    Name = "${format("%s-internet-gateway", local.full_project_name)}"
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

resource "aws_db_subnet_group" "jpadjasek_subnet_group" {
  name = "jpadjasek_subnet_group"
  subnet_ids = [aws_subnet.jpadjasek_subnet_public_AZ2.id, aws_subnet.jpadjasek_subnet_public_AZ1.id]
}
