module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.app_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs
  create_igw      = true
  tags = {
    Environment = var.env
    App         = var.app_name
  }
}
