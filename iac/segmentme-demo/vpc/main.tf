module "bastion" {
  source = "../../modules/bastion/"

  name                  = "${var.project_name}-${var.environment}"
  bastion_key_pair_name = "${var.project_name}-${var.environment}"
  vpc_id                = module.vpc.vpc_id
  vpc_subnet_id         = element(module.vpc.public_subnets,length(module.vpc.public_subnets)-1)
  ami_id                = var.bastion_ami_id

  allowed_cidr_block    = ["0.0.0.0/0"]

  tags = {
    Owner       = var.owner
    Environment = var.environment
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.7.0"

  name = "${var.project_name}-${var.environment}"

  cidr = "10.10.0.0/16"

  azs                   = ["us-east-1a", "us-east-1b"]
  private_subnets       = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets        = ["10.10.11.0/24", "10.10.12.0/24"]

  create_database_subnet_group = false

  enable_dns_hostnames  = true
  enable_dns_support    = true

  enable_nat_gateway    = true
  single_nat_gateway    = true

  private_subnet_tags = {
    "Name" = "${var.project_name}-${var.environment}-private-subnet"
    "Tier" = "private"
  }

  public_subnet_tags = {
    "Name" = "${var.project_name}-${var.environment}-public-subnet"
    "Tier" = "public"
  }

  nat_gateway_tags   = {
    "Name" = "${var.project_name}-${var.environment}-nat-gateway"
  }

  igw_tags            = {
    "Name" = "${var.project_name}-${var.environment}-internet-gateway"
  }

  vpc_tags            = {
    "Name" = "${var.project_name}-${var.environment}-vpc"
  }

  tags = {
    Owner                               = var.owner
    Environment                         = var.environment
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "bastion_sg_id" {
  value = module.bastion.bastion_sg_id
}