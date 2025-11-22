provider "aws" {
  region = var.region
}

module "network" {
  source           = "./modules/network"
  region           = var.region
  project          = "ivolve"
  vpc_cidr         = "10.0.0.0/16"
  public_subnet_1  = "10.0.1.0/24"
  public_subnet_2  = "10.0.2.0/24"
}

module "server" {
  source         = "./modules/server"
  project        = "ivolve"
  ami_id         = "ami-0c02fb55956c7d316" 
  public_subnets = module.network.public_subnets
  vpc_id         = module.network.vpc_id
}

