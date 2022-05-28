resource "aws_instance" "count_demo" {
  count = 2
  ami = "ami-08e4e35cccc6189f4"
  instance_type = "t2.micro"
  tags = {
     Name = "Terraform_Demo_Instance - ${count.index}"
  }


}
