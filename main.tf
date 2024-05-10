provider "google" {
  project     = "shaped-crawler-417213"
  region      = "us-central1"
}

resource "google_compute_network" "vpc_network" {
  name = "test-network"
}

resource "google_compute_address" "static_ip" {
  name = "debian-vm"
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

resource "google_compute_instance" "debian-vm" {
  name         = "my-instance"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"
  # count = 2

  tags = ["hpc"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
    
  }

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }

  metadata_startup_script = "echo hi > /test.txt"

  scheduling {
    preemptible = true
    automatic_restart = false
    provisioning_model = "SPOT"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

    connection {
      host        = self.network_interface[0].access_config[0].nat_ip
      type        = "ssh"
      user        = "${split("@", data.google_client_openid_userinfo.me.email)[0]}"
      private_key = tls_private_key.ssh.private_key_pem
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u 'antonio.medeiros' -i '${self.network_interface[0].access_config[0].nat_ip},' --private-key .ssh/google_compute_engine -e 'pub_key=.ssh/google_compute_engine.pub' enviroment-setup.yml"
  }

}

output "public_ip" {
  value = google_compute_address.static_ip.address
}
