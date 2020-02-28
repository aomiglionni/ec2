resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = "default"

  tags = {
    Name = "vpc-teste"
  }
}

resource "aws_subnet" "subnet_priv_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_priv_1a
  availability_zone = var.az_1a

  tags = {
    Name = "subnet-priv-1a"
  }
}

resource "aws_subnet" "subnet_priv_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_priv_1b
  availability_zone = var.az_1b

  tags = {
    Name = "subnet-priv-1b"
  }
}

resource "aws_subnet" "subnet_pub_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_pub_1a
  availability_zone = var.az_1a

  tags = {
    Name = "subnet-pub-1a"
  }
}

resource "aws_subnet" "subnet_pub_1b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block_pub_1b
  availability_zone = var.az_1b

  tags = {
    Name = "subnet-pub-1b"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Gw VPC Teste"
  }
}

resource "aws_route_table" "route_pub" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.cidr_block_internet
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Route Subnet Pub"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_pub_1b.id
  route_table_id = aws_route_table.route_pub.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_pub_1a.id
  route_table_id = aws_route_table.route_pub.id
}
