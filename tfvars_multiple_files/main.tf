provider "aws" {
  region     = "ap-southeast-1"
  access_key = "XXXXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

resource "aws_instance" "terraform_multiple_tfvars_demo" {
    ami = "ami-04d9e855d716f9c99"  
    instance_type = var.instance_type 
    tags = {
        Name = var.environment_name
    }
}