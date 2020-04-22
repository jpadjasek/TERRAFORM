
locals {
  full_project_name         = "${var.project_name}-${var.stage}"
  launch_configuration_name = "${format("%s-ec2-Launch", local.full_project_name)}"
  austoscaling_group_name   = "${format("%s-autoscaling-group", local.full_project_name)}"
}

resource "aws_launch_configuration" "ec2Launch" {
  image_id        = "ami-006a0174c6c25ac06"
  instance_type   = "t2.micro"
  name = local.launch_configuration_name
  security_groups = [var.security_group_id]
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name = local.austoscaling_group_name
  launch_configuration = aws_launch_configuration.ec2Launch.id
  vpc_zone_identifier = [var.subnet_id_1, var.subnet_id_2]
  min_size = 2
  max_size = 2
  tag {
    key                 = "Name"
    value               = local.austoscaling_group_name
    propagate_at_launch = true
  }
}
