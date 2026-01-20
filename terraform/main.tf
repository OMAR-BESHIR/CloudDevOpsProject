module "network" {
  source             = "./modules/network"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}

module "jenkins_server" {
  source        = "./modules/server"
  vpc_id        = module.network.vpc_id
  subnet_id     = module.network.public_subnet_ids[0]
  instance_type = var.instance_type
  key_name      = var.key_name
}

