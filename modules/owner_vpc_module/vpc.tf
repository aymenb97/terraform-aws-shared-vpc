resource "aws_vpc" "_" {
  cidr_block         = var.vpc_cidr
  enable_dns_support = true
  tags = {
    "Name" = "owner-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc._.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.az
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc._.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc._.id
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc._.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block         = "172.16.0.0/12"
    transit_gateway_id = aws_ec2_transit_gateway._.id
  }
  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = aws_ec2_transit_gateway._.id
  }
  route {
    cidr_block         = "192.168.0.0/16"
    transit_gateway_id = aws_ec2_transit_gateway._.id
  }
}
resource "aws_route_table_association" "_" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.public.id
}
