provider "aws" {
      region     = "${var.region}"
      access_key = "${var.aws_access_key}"
      secret_key = "${var.aws_access_key}"
}
# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}