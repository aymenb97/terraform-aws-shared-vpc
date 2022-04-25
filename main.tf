module "owner_vpc" {
  source              = "./modules/owner_vpc_module"
  vpc_cidr            = "10.0.0.0/16"
  private_subnet_cidr = "10.0.0.0/24"
}
module "participant_vpc" {
  source      = "./modules/participant_vpc"
  tgw_id      = module.owner_vpc.tgw_id
  vpc_cidr    = "192.168.0.0/16"
  subnet_cidr = "192.168.0.0/24"

}
module "route_53_hosted_zone" {
  source          = "./modules/route53_private_hosted_zone"
  owner_vpc       = module.owner_vpc.vpc_id
  participant_vpc = module.participant_vpc.vpc_id
  zone_name       = "example.com"
}
