resource "google_compute_network" "vpc_network" {
  name = "hpc-network"
}

resource "google_compute_address" "static_ip" {
  name = "hpc-vm"
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["hpc"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

data "google_client_openid_userinfo" "me" {}

# resource "google_compute_router" "router" {
#   name    = "router"
#   network = google_compute_network.vpc_network.name
# }

# resource "google_compute_router_nat" "nat" {
#   name         = "nat"
#   router       = google_compute_router.router.name
#   nat_ip_allocate_option = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
# }
