resource "aws_ram_resource_share" "_" {
    name = "transit-gateway"
    allow_external_principals = false
}

data "aws_organizations_organization" "_" {
  
}

resource "aws_ram_principal_association" "_" {
    #The prinicpal to associate with the resource share
    principal = data.aws_organizations_organization._.arn
    resource_share_arn = aws_ram_resource_share._.arn
}
