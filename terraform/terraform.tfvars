env           = "test"
app_name      = "sample_ec2_webapp"
ami_id        = "ami-098f55b4287a885ba"
instance_type = "t2.medium"
vpc_cidr      = "10.202.0.0/16"
source_cidr = [
  "47.185.188.132/32"
]
availability_zones   = ["us-west-1b", "us-west-1c"]
public_subnet_cidrs  = ["10.202.101.0/24", "10.202.102.0/24"]
private_subnet_cidrs = ["10.202.1.0/24", "10.202.2.0/24"]
