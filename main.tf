module "vpc" {
  source = "./modules/vpc"
  vpc_name = var.vpc_name
}

module "nfs" {
  source = "./modules/nfs"
  vpc_name = module.vpc.vpc_network_name
}

module "firewall" {
  source = "./modules/firewall"
  vpc_name = module.vpc.vpc_network_name
}

# module "ssh-key" {
#   source = "./modules/ssh-key"
# }

provider "google" {
  project = var.project_id
  region  = var.region
}