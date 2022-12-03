module "bootcamp_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bootcamp-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    name = "bootcamp-vpc"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

/*
module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group para o servidor do Jenkins Server"
  vpc_id      = module.bootcamp_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "grafana_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "grafana-sg"
  description = "Security group para o servidor do grafana Server"
  vpc_id      = module.bootcamp_vpc.vpc_id
  
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      description = "Grafana Port"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_rules        = ["all-all"]
}
*/
module "osticket_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "osTicket-sg"
  description = "Security group para o servidor do osTicket Server"
  vpc_id      = module.bootcamp_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "OsTicket Port"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_rules        = ["all-all"]
}
/*
module "jenkins_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = "Jenkins-Server"
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = "terraform"
  monitoring             = true
  vpc_security_group_ids = [module.jenkins_sg.security_group_id]
  subnet_id              = module.bootcamp_vpc.public_subnets[0]
  user_data              = file("./jenkins.sh")

  tags = {
    Terraform = "true"
  }
}

module "grafana_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = "Grafana-Server"
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "terraform"
  monitoring             = true
  vpc_security_group_ids = [module.grafana_sg.security_group_id]
  subnet_id              = module.bootcamp_vpc.public_subnets[0]
  user_data              = file("./grafana.sh")

  tags = {
    Terraform = "true"
  }
}
*/
module "osticket_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = "OSticket-Server"
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name               = "terraform"
  monitoring             = true
  vpc_security_group_ids = [module.osticket_sg.security_group_id]
  subnet_id              = module.bootcamp_vpc.public_subnets[0]
  user_data              = file("./osticket.sh")

  tags = {
    Terraform = "true"
  }
}
/*
resource "aws_eip" "jenkins-ip" {
  instance = module.jenkins_ec2_instance.id
  vpc      = true
}

resource "aws_eip" "grafana-ip" {
  instance = module.grafana_ec2_instance.id
  vpc      = true
}
*/
resource "aws_eip" "osticket-ip" {
  instance = module.osticket_ec2_instance.id
  vpc      = true
}