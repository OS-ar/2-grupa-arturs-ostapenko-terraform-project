variable "region" {    
    default = "us-west-2"
}
variable "aws_secret_key" {
    description = " Secret key to AWS console"
}
variable "aws_access_key" {
    description = "Access key to AWS console"
}
variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}
variable "public_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
  type        = list
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["eu-west-3a", "eu-west-3b"]
  type        = list
  description = "List of availability zones"
}