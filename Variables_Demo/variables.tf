variable "ami_type" { 
  type = map(string)
  default = {
        us-east-1 = "ami-0a8b4cd432b1c3063"
  	us-east-2 = "ami-0231217be14a6f3ba"
  }
}

variable "env" {
}

variable "region" {
  
}

variable "instance_type" {
  type = map(string)
  default = {
    dev = "t2.micro"
    test = "t2.micro"
  }
}
