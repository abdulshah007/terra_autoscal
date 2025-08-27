variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "subnets_cidr" {
  type = list
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "azs" {
  type = list
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "webservers_ami" {
  default = "ami-0e4bd026c1aaf16eb"
}

variable "instance_type" {
  default = "t2.nano"
}
