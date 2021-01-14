variable "env" {
  default = "dev"
}
variable "app_name" {
  default = "sample_ec2_webapp"
}
variable "ami_id" {
  default = "ami-098f55b4287a885ba"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "vpc_cidr" {
  default = "10.202.0.0/16"
}
variable "source_cidr" {
  type = list(string)
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-west-1b", "us-west-1c"]
}
variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.202.101.0/24", "10.202.102.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.202.1.0/24", "10.202.2.0/24"]
}
