resource "aws_vpc" "principal_vpc" {
    cidr_block = var.principal_vpc_cidr
    enable_dns_support = true
}
resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.principal_vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id=aws_vpc.principal_vpc.id
    cidr_block=var.private_subnet_cidr
}
