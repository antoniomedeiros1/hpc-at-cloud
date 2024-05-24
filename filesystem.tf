resource "google_filestore_instance" "instance" {
  name     = "homefs"
  location = "us-central1-a"
  tier     = "BASIC_HDD"

  file_shares {
    capacity_gb = 1024
    name        = "share1"
  }

  networks {
    network = google_compute_network.vpc_network.name
    modes   = ["MODE_IPV4"]
  }

}
