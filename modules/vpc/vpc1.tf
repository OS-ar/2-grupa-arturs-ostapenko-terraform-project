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

############EIP###############
resource "aws_eip" "nat" {
  vpc = true
}

########## Subnets ####################
resource "aws_subnet" "pub-subnet" {
  for_each = var.public_subnet
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = each.value
  availability_zone = var.availability_zone
  tags = {
    Name = "pub-subnet"
  }
}
resource "aws_subnet" "private-subnet" {
  for_each = var.private_subnet
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = each.value
  availability_zone = var.availability_zone
  tags = {
    Name = "private-subnet"
  }
}

#########Route table#####################
resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ao-gw.id
  }

  tags = {
    Name = "public route"
  }
}
resource "aws_route_table_association" "pub_route_association" {
  subnet_id = aws_subnet.pub-subnet["public1"].id
  route_table_id = aws_route_table.pub-route-table.id
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_public.id
  }

  tags = {
    Name = "public route"
  }
}
resource "aws_route_table_association" "private_route_association" {
  subnet_id = aws_subnet.private-subnet["private1"].id
  route_table_id = aws_route_table.private-route-table.id
}

########### Route table association##################
#resource "aws_route_table_association" "main-rta-a" {
#  for_each = aws_subnet.pub-subnet[each.key]
#  subnet_id      = each.key.id
#  route_table_id = aws_route_table.ao-route-table.id
#}
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

resource "aws_nat_gateway" "nat_public" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.pub-subnet["public1"].id 

  tags = {
    Name = "public gw NAT"
  }
}