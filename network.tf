resource "aws_internet_gateway" "principal-igw" {
  vpc_id = aws_vpc.principal-vpc.id

}
resource "aws_route_table" "principal-public-route-table" {
  vpc_id = aws_vpc.principal-vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.principal-igw.id
  }

}
