variable "region" {
  description = "AWS Region"
  type        = string
  default = "eu-west-1"

}

variable "principal_vpc_cidr" {
  description = "VPC Cidr Block"
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "Public Subnet CIDR Block"
  type        = string
  default = "10.0.1.0/24"
  

}
variable "private_subnet_cidr" {
    description = "Private Subnet CIDR Block"
    type = string
    default = "10.0.2.0/24"
  
}