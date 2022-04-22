resource "aws_internet_gateway" "principal_igw" {
  vpc_id = aws_vpc.principal_vpc.id
}
resource "aws_route_table" "principal_public_route_table" {
  vpc_id = aws_vpc.principal_vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.principal_igw.id
  }

}
