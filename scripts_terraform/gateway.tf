resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "VPC"
    Description = "Ejempl VPC con 2 sub redes "
  }

}

resource "aws_internet_gateway" "inet" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "internet gateway"
  }
}


resource "aws_default_route_table" "public" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inet.id
  }

  tags = {
    Name = "tabla de ruteo"
  }
}

resource "aws_subnet" "a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1e"

  tags = {
    Name = "sub red a"
  }

  map_public_ip_on_launch = true
}

resource "aws_subnet" "b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1d"


  tags = {
    Name = "sub red b"
  }

  map_public_ip_on_launch = true
}