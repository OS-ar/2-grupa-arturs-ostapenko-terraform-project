##########VPC#################
resource "aws_vpc" "main-vpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}
#########IGW##############
resource "aws_internet_gateway" "ao-gw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "ao-gw"
  }
}

########## Subnets ####################
resource "aws_subnet" "pub-subnet" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "${var.public_subnet}"
  availability_zone = "${var.availability_zone}"
  tags = {
    Name = "pub-subnet"
  }
}
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "${var.private_subnet}"
  availability_zone = "${var.availability_zone}"
  tags = {
    Name = "pub-subnet"
  }
}

#########Route table#####################
resource "aws_route_table" "ao-route-table" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ao-gw.id
  }

  tags = {
    Name = "tf"
  }
}
########### Route table association##################
resource "aws_route_table_association" "main-rta-a" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.ao-route-table.id
}
########## Security Group #################
resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow WEB inbound traffic"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["136.169.60.108/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_https"
  }
}