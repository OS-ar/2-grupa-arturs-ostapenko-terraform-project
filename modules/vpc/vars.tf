variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}
variable "public_subnet" {
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet" {
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
  type        = list
  description = "List of private subnet CIDR blocks"
}

variable "availability_zone" {
  default     = ["us-west-2"]
  type        = list
  description = "List of availability zones"
}