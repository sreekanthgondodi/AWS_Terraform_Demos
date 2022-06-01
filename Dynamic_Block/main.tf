provider "aws" {
  region     = "ap-southeast-1"
  access_key = "XXXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

locals {
   ingress_rules = [{
      port        = 443
      description = "Ingress rules for port 443"
   },
   {
      port        = 22
      description = "Ingree rules for port 22"
   }]
}

resource "aws_instance" "EC2_Example" {
   ami           = "ami-04d9e855d716f9c99"
   instance_type = "t2.micro"
   key_name = "key-for-ec2"
   vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_security_group" "main" {
    egress = [
        {
            cidr_blocks = ["0.0.0.0/0", ]
            description = ""
            from_port = 0
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            protocol = "tcp"
            security_groups = []
            self = false
            to_port = 0
        }
    ]

   dynamic "ingress" {
      for_each = local.ingress_rules
      content {
         description = ingress.value.description
         from_port   = ingress.value.port
         to_port     = ingress.value.port
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
      }
   }

   tags = {
      Name = "AWS security group dynamic block"
   }
}