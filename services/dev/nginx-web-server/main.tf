provider "aws" {
      region     = "${var.region}"
      access_key = "${var.aws_access_key}"
      secret_key = "${var.aws_access_key}"
}
# Modules

module "vpc" {
  source = "../../modules/vpc"
  
}
module "ec2" {
  source = "../../modules/ec2"
  
}