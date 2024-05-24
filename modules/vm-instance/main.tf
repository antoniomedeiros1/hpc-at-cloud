data "google_client_openid_userinfo" "me" {}

resource "google_compute_address" "static_ip" {
  name = "hpc-static-ip-${var.instance_name}"
}

resource "google_compute_instance" "hpc-vm" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.instance_zone

  tags = ["hpc", "allow-ssh"]

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = var.vpc_name

    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${var.public_key_openssh}"
  }

  metadata_startup_script = "echo hi > /test.txt"

  scheduling {
    preemptible = true
    automatic_restart = false
    provisioning_model = "SPOT"
  }

  # provisioner "remote-exec" {
  #   inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done!"]

  #   connection {
  #     host        = self.network_interface[0].access_config[0].nat_ip
  #     type        = "ssh"
  #     user        = "${split("@", data.google_client_openid_userinfo.me.email)[0]}"
  #     private_key = tls_private_key.ssh.private_key_pem
  #   }
  # }

  # provisioner "local-exec" {
  #   command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u 'antonio.medeiros' -i '${self.network_interface[0].access_config[0].nat_ip},' --private-key .ssh/google_compute_engine -e 'pub_key=.ssh/google_compute_engine.pub' enviroment-setup.yml"
  # }
}
