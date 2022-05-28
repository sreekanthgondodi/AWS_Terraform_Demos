resource "aws_instance" "variable_demo" {
  
 count = 1 
 ami = "${lookup(var.ami_type, var.region)}"
 
 instance_type = "${lookup(var.instance_type, var.env)}" 
  tags = {
     Name = "Terraform_Demo_Instance - ${count.index}"
  }


}
d