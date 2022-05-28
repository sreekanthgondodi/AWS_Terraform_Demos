provider "aws" {
  region     = "ap-southeast-1"
  access_key = "XXXXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

variable location {
  description = "Location of server"
  type        = string
  default     = "Singapore"
}

variable server_name {
  description = "Name of server"
  type        = string
  default     = "primary-app-server"
}

locals {
    staging_env = "Dev"
    server_details = "${var.location}-${var.server_name}"
}

resource "aws_vpc" "staging-vpc" {
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.staging_env}-vpc-tag"
  }
}

resource "aws_subnet" "staging-subnet" {
  vpc_id = aws_vpc.staging-vpc.id
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "${local.staging_env}-subnet-tag"
  }
}

resource "aws_instance" "ec2_local_example" {
   
   ami           = "ami-04d9e855d716f9c99"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.staging-subnet.id
   
   tags = {
           Name = "${local.staging_env} - Terraform EC2"
           Server_Location = "${local.server_details} - Server Location "
   }
}