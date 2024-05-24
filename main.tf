module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
}

module "firewall" {
  source = "./modules/firewall"
  vpc_name = module.vpc.vpc_network_name
}

module "ssh-key" {
  source = "./modules/ssh-key"
}

module "vm-instance-1" {
  source = "./modules/vm-instance"
  vpc_name = module.vpc.vpc_network_name
  tls_private_key = module.ssh-key.tls_private_key
  instance_name = "node-1"
}

module "vm-instance-2" {
  source = "./modules/vm-instance"
  vpc_name = module.vpc.vpc_network_name
  tls_private_key = module.ssh-key.tls_private_key
  instance_name = "node-2"
}

module "nfs" {
  source = "./modules/nfs"
  vpc_name = module.vpc.vpc_network_name
  tls_private_key = module.ssh-key.tls_private_key
}

provider "google" {
  project = var.project_id
  region  = var.region
}