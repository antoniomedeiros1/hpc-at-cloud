resource "google_compute_network" "vpc_network" {
  name = var.vpc_name
}

data "google_client_openid_userinfo" "me" {}