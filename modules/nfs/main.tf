data "google_client_openid_userinfo" "me" {}
resource "google_compute_address" "nfs_static_ip" {
  name = "nfs-server"
}

resource "google_compute_instance" "nfs" {
  name = "nfs-server"
  machine_type = "n2-standard-2"
  zone = "us-central1-a"

  tags = ["nfs", "allow-ssh"]

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

  network_interface {
    network = var.vpc_name

    access_config {
      nat_ip = google_compute_address.nfs_static_ip.address
    }
  }

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${var.public_key_openssh}"
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")
}