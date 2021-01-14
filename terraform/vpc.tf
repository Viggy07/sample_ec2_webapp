module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.app_name
  cidr = "10.202.0.0/16"

  azs  = ["us-west-1a","us-west-1b"]
  public_subnets =  ["10.202.101.0/24", "10.202.102.0/24"]
  private_subnets = ["10.202.1.0/24","10.202.1.0/24"]
  create_igw = true
  tags = {
    Environment = "test"
    App = var.app_name
  }
}
