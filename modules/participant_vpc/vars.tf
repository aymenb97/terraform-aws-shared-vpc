variable "vpc_cidr" {
  description = "CIDR Block of Participant VPC"
  type        = string
}
variable "subnet_cidr" {
  description = "CIDR Block of Participant subnet"
  type        = string
}
variable "az" {
  description = "Subnet Availability Zone"
  default     = "us-east-1a"

}

variable "tgw_id" {
  description = "ID of Transit Gateway"
  type        = string

}
