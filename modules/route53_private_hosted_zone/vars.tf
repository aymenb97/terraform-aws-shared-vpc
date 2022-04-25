variable "zone_name" {
  description = "Name of the hosted Zone"
  type        = string
}
variable "owner_vpc" {
  description = "ID of the owner VPC"
  type        = string
}
variable "participant_vpc" {
  description = "ID of the participant VPC"
  type        = string
}
