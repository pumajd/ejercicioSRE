# LB load balance balanceador de carga
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


# grupo de balanceardor de carga
resource "aws_lb_target_group" "web" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

# Listener del balanceador
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

# Zona dns
resource "aws_route53_zone" "primary" {
  name = "josed.com"
}

# Interface de red
resource "aws_network_interface" "interfaz" {
  subnet_id   = aws_subnet.a.id
  private_ips = ["10.0.0.12"]
  security_groups = [aws_security_group.web.id,]	
  tags = {
    Name = "primary_network_interface"
  }
}

# ip publica elastica
resource "aws_eip" "lb" {
  instance = aws_instance.instancia.id
  vpc      = true
}

