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
