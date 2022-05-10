variable "region" {    
    default = "us-west-2"
}
variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.medium"
}