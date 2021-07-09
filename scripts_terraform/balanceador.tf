resource "aws_lb" "web" {
  name               = "web"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_default_security_group.interno.id,
    aws_security_group.web.id,
  ]
  subnets = [
    aws_subnet.a.id,
    aws_subnet.b.id
  ]

}



resource "aws_lb_target_group" "web" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}


resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_route53_zone" "primary" {
  name = "josed.com"
}

resource "aws_network_interface" "interfaz" {
  subnet_id   = aws_subnet.a.id
  private_ips = ["10.0.0.12"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "instancia" {
  ami                    = "ami-02073b6d72494fefa"
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

resource "aws_eip" "lb" {
  instance = aws_instance.instancia.id
  vpc      = true
}












