provider "aws" {
  region     = "ap-southeast-1"
  access_key = "XXXXXXXXXXXXXXXXXXXXX"
  secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}
resource "aws_instance" "ec2__Iteration_example" {

   ami           = "ami-04d9e855d716f9c99"
   instance_type =  "t2.micro"
   count = 1

   tags = {
           Name = "Terraform Loops EC2"
   }

}

# For Each
variable "user_names_set" {
  description = "IAM usernames"
  type        = set(string)
  default     = ["user1", "user2", "user3"]
}

resource "aws_iam_user" "example" {
  for_each = var.user_names_set
  name  = each.value
}

# For Loop
variable "user_names_list" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}

output "print_the_names" {
  value = [for name in var.user_names_list : name]
}



# MAP Demo

variable "iam_users_map" {
  description = "IAM USERS MAP"
  type        = map(string)
  default     = {
    user1      = "normal user"
    user2  = "admin user"
    user3 = "root user"
  }
}

output "user_with_roles" {
  value = [for name, role in var.iam_users_map : "${name} is the ${role}"]
}