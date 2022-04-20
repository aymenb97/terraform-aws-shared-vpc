resource "aws_vpc" "principal-vpc" {
    cidr_block = var.principal_vpc_cidr
    enable_dns_support = true
}
resource "aws_subnet" "public-subnet-1" {
    vpc_id = aws_vpc.principal-vpc.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "private-subnet-1" {
    vpc_id="${aws_vpc.principal-vpc.id}"
    cidr_block=var.private_subnet_cidr
}
