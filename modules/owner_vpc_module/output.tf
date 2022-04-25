output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
output "tgw_id" {
  value = aws_ec2_transit_gateway._.id
}
