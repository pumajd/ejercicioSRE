
# DUPLICAR PARA HACER 2
resource "aws_launch_template" "weba" {
  name_prefix   = "web-lt-"
  image_id      = var.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.web.id,
  ]
}



resource "aws_instance" "instancia" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  monitoring             = true
   network_interface {
    network_interface_id = aws_network_interface.interfaz.id
    device_index         = 0
  }
  
  vpc_security_group_ids = [
      aws_security_group.web.id,
  ]
  tags          = {
    Name        = "Application Server"
    Environment = "production"
  }
   root_block_device {
    delete_on_termination = true
  }
}


# registro en le balanceo de carga de la interfaz
resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.instancia.id
  port             = 80
}


# escalamiento grupo de escalamiento
resource "aws_placement_group" "web" {
  name     = "web-pl"
  strategy = "partition"
}

# configuración de lanzamiento
resource "aws_launch_template" "web" {
  name_prefix   = "web-lt-"
  image_id      = var.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_default_security_group.interno.id,
  ]
}

# grupo de escalamiento
resource "aws_autoscaling_group" "web" {
  name                = "webscale"
  vpc_zone_identifier = [aws_subnet.a.id, aws_subnet.b.id]
  desired_capacity    = 2
  max_size            = 4
  min_size            = 2
  placement_group     = aws_placement_group.web.id
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}

# registro de escalamiento
resource "aws_autoscaling_attachment" "web" {
  autoscaling_group_name = aws_autoscaling_group.web.id
  alb_target_group_arn   = aws_lb_target_group.web.arn
}