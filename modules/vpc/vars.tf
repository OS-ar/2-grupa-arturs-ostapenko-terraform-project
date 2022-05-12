variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}
variable "public_subnet"{
  type = map

  default ={
    "public1" = "10.0.0.0/24"
    "public2" = "10.0.2.0/24"
  } 
}

variable "private_subnet"{
  type = map

  default ={
    "private1" = "10.0.0.0/24"
    "private2" = "10.0.2.0/24"
  } 
}

variable "availability_zone" {
  default     = "us-west-2"
  type        = string
  description = "List of availability zones"
}