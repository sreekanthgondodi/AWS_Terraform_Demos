provider "aws" {
  region     = "ap-southeast-1"
<<<<<<< HEAD
  access_key = "XXXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXX"
=======
  access_key = "XXXXXXXXXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
>>>>>>> 2d0ddaabc3ffdff0f9b07d016e7b5a9b0fe5e132
}

resource "aws_instance" "terraform_ec2_demo" {
    ami = "ami-04d9e855d716f9c99"  
    instance_type = "t2.micro" 
    tags = {
        Name = "Terraform EC2"
    }
}
