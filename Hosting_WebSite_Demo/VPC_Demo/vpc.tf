data "aws_availability_zones" "available" {}

# Main vpc
resource "aws_vpc" "main" {
  cidr_block = "${var.VPC_CIDR_BLOCK}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}

# SUBNETS

## Public Subnet - 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.VPC_PUBLIC_SUBNET1_CIDR_BLOCK}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.PROJECT_NAME}-vpc-public-subnet-1"
  }
}

## Public Subnet - 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.VPC_PUBLIC_SUBNET2_CIDR_BLOCK}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.PROJECT_NAME}-vpc-public-subnet-2"
  }
}


## Private Subnet - 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.VPC_PRIVATE_SUBNET1_CIDR_BLOCK}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.PROJECT_NAME}-vpc-private-subnet-1"
  }
}

## Private Subnet - 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.VPC_PRIVATE_SUBNET2_CIDR_BLOCK}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "${var.PROJECT_NAME}-vpc-private-subnet-2"
  }
}


# Internet Gateway configuration
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${var.PROJECT_NAME}-vpc-internet-gateway"
  }
}

# Elastic IP for NAT gateway
resource "aws_eip" "nat_eip" {
  vpc = "true"
  depends_on = [aws_internet_gateway.igw]
}

# NAT gateway for private ip address
resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.PROJECT_NAME}-vpc-NAT-gateway"
  }
}

# Route Table configuration for public subnets

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "${var.PROJECT_NAME}-public-route-table "
  }
}

# Route Table configuration for private subnets
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.ngw.id}"
  }

  tags = {
    Name = "${var.PROJECT_NAME}-private-route-table "
  }
}

# Route table association for public subnets
resource "aws_route_table_association" "to_public_subnet1" {
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "to_public_subnet2" {
  subnet_id = "${aws_subnet.public_subnet_2.id}"
  route_table_id = "${aws_route_table.public.id}"
}

# Route table association for private subnets
resource "aws_route_table_association" "to_private_subnet1" {
  subnet_id = "${aws_subnet.private_subnet_1.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "to_private_subnet2" {
  subnet_id = "${aws_subnet.private_subnet_2.id}"
  route_table_id = "${aws_route_table.public.id}"
}
