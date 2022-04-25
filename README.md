# terraform-shared-vpc

VPC sharing allows customers to share subnets with other AWS accounts within the same AWS Organization.

In the following example, we create two VPCs (Owner VPC and a Participant VPC) and link them with Transit Gateway.

## How it works:
1. Create a VPC in the owner account.
2. Create a Transit Gateway and add it as a resource share.
3. Attach the transit gateway to the VPC.
4. Create a participant VPC.
5. Attach the participant VPC to the Transit Gateway.

## Architecture

 ![enter image description here](https://drive.google.com/uc?id=1RbxGix-S1a9OcwNYC4uJingHsGiQSTS7)

## Prerequisites:
 - AWS RAM must be enabled in the master account of your AWS Organization.
 - Owners can share subnets only with other accounts or organizational units that are in the same organization from AWS Organizations.
 - Permissions to manage VPCs, Transit Gateways and internet Gateways.
 <!-- BEGIN_OWNER_VPC_MODULE -->
# Owner VPC
- Create a VPC with a public Subnet.
- Create an Internet Gateway.
- Create a route table and attach it to the subnet.
- Create a Transit Gateway and attaches it to the VPC.
- Create a route table and attach it to the subnet.
- Add the Inernet Gateway, Tranist Gateway routes to the route table.
- Add the Transit Gateway as a Resource Share. 

## Requirements

No requirements.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway._](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route._](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_vpc_attachment._](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association._](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc._](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az"></a> [az](#input\_az) | Availability Zone for the VPC | `string` | `"us-east-1a"` | no |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | Private Subnet CIDR Block | `string` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | Public Subnet CIDR Block | `string` | `"10.0.1.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-1a"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC Cidr Block | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_tgw_id"></a> [tgw\_id](#output\_tgw\_id) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_OWNER_VPC_MODULE_DOCS -->
<!-- BEGIN_PARTICIPANT_VPC_MODULE_DOCS -->
# Participant VPC
- Create a VPC with a public Subnet.
- Create an Internet Gateway.
- Create a route table and attach it to the subnet.
- Add the Inernet Gateway, Tranist Gateway routes to the route table.
- Attach the Transit gateway to the VPC.

## Requirements

No requirements.


## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_vpc_attachment._](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc._](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az"></a> [az](#input\_az) | Subnet Availability Zone | `string` | `"us-east-1a"` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | CIDR Block of Participant subnet | `string` | n/a | yes |
| <a name="input_tgw_id"></a> [tgw\_id](#input\_tgw\_id) | ID of Transit Gateway | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR Block of Participant VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
<!-- END_PARTICIPANT_VPC_MODULE_DOCS -->
<!-- BEGIN_ROUTE53_ZONE_DOCS -->
# Route 53 Private Hosted Zone

- Create a Route 53 private hosted zone.
- Add the two created VPCs to the hosted zone.
## Requirements

No requirements.


## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_owner_vpc"></a> [owner\_vpc](#input\_owner\_vpc) | ID of the owner VPC | `string` | n/a | yes |
| <a name="input_participant_vpc"></a> [participant\_vpc](#input\_participant\_vpc) | ID of the participant VPC | `string` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Name of the hosted Zone | `string` | n/a | yes |

<!-- END_TF_DOCS -->