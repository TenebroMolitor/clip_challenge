#----networking/main.tf----

data "aws_availability_zones" "available" {
}

resource "aws_vpc" "tf_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_default_route_table" "tf_private_rt" {
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id

  tags = {
    Name = "tf_private"
  }
}

resource "aws_subnet" "tf_private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.tf_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "tf_private_${count.index + 1}"
  }
}

resource "aws_route_table_association" "tf_private_assoc" {
  count          = length(aws_subnet.tf_private_subnet)
  subnet_id      = aws_subnet.tf_private_subnet[count.index].id
  route_table_id = aws_default_route_table.tf_private_rt.id
}

resource "aws_security_group" "tf_private_sg" {
  name        = "tf_private_sg"
  description = "Used for access to the private instances"
  vpc_id      = aws_vpc.tf_vpc.id

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.accessip]
  }
}

