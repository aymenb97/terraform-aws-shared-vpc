resource "aws_route53_zone" "private" {
  name = var.zone_name
  vpc {
    vpc_id = var.owner_vpc
  }
  vpc {
    vpc_id = var.participant_vpc
  }
}
