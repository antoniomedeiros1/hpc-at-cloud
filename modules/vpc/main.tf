resource "google_compute_network" "vpc_network" {
  name = "hpc-network"
}

resource "google_compute_address" "static_ip" {
  name = "hpc-vm"
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["hpc", "nfs"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}