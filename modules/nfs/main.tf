resource "google_compute_instance" "nfs" {
  name = "nfs-server"
  machine_type = "n2-standard-2"
  zone = "us-central1-a"

  tags = ["nfs"]

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }
}