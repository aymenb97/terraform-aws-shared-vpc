variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr" {
  description = "VPC Cidr Block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR Block"
  type        = string
  default     = "10.0.1.0/24"
}


variable "private_subnet_cidr" {
  description = "Private Subnet CIDR Block"
  type        = string
}

variable "az" {
  description = "Availability Zone for the VPC"
  type        = string
  default     = "us-east-1a"
}
