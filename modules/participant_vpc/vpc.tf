resource "aws_vpc" "_" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    "Name" = "participant-vpc"
  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc._.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.az
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc._.id
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc._.id
  route {
    cidr_block         = "172.16.0.0/12"
    transit_gateway_id = var.tgw_id
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block         = "10.0.0.0/8"
    transit_gateway_id = var.tgw_id
  }

}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.public.id
}
