module "bootcamp_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bootcamp-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "prod"
    Name = "bootcamp-vpc"
    Alunos = "Fabiano e Diego"
  }
}

