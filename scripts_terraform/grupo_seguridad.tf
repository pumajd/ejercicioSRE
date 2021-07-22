# Grupo de seguridad por defecto
resource "aws_default_security_group" "interno" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "default interno sg"
  }

  ingress {
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
    description = "self ref"
  }

  egress {
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
    description = "self ref"
  }

}

# Grupo de seguridad para la web
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Acceso web"
  }

  ingress {
    description      = "trafico http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "trafico https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    description      = "trafico https"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


}



# Grupo de seguridad para la bdd
resource "aws_security_group" "bdd" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Acceso bdd"
  }

  
  ingress {
    description      = "trafico bddd"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    description      = "trafico ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


}