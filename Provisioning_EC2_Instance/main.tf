provider "aws" {
  region     = "ap-southeast-1"
  access_key = "AKIAU2MGKZNNFYLN2BWB"
  secret_key = "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"
}

resource "aws_instance" "terraform_ec2_demo" {
    ami = "ami-04d9e855d716f9c99"  
    instance_type = "t2.micro" 
    tags = {
        Name = "Terraform EC2"
    }
}