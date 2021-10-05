#----root/main.tf-----
provider "aws" {
  region = var.aws_region
}


# Deploy Networking Resources
module "networking" {
  source        = "./networking"
  vpc_cidr      = var.vpc_cidr
  private_cidrs = var.private_cidrs
  accessip      = var.accessip
}

# Deploy Compute Resources
module "compute" {
  source          = "./compute"
  instance_count  = var.instance_count
  key_name        = var.key_name
  public_key_path = var.public_key_path
  instance_type   = var.server_instance_type
  subnets         = [module.networking.private_subnets[0]]
  security_group  = module.networking.private_sg
  subnet_ips      = module.networking.subnet_ips
}

# Deploy Database Resources
module "database" {
  source  = "./database"
  db_name = var.db_name
  subnets = module.networking.private_subnets
}