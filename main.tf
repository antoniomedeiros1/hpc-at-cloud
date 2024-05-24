module "vpc" {
  source = "./modules/vpc"
}

module "nfs" {
  source = "./modules/nfs"
}

module "firewall" {
  source = "./modules/firewall"
}

provider "google" {
  project = var.project_id
  region  = var.region
}