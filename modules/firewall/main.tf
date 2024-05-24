resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = var.vpc_name
  target_tags   = var.target_tags
  source_ranges = var.source_ranges

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}