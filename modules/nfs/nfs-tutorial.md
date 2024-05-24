# Deploying a NFS Server in GCP with Terraform

Sometimes all we want is a simple NFS server to share files between our instances, without paying for overpriced managed services. In this tutorial, we will deploy a NFS server in a Google Cloud instance using Terraform.

## Prerequisites

You will need the following tools installed in your local machine:
- Terraform
- Google Cloud CLI 
- Ansiible

You will also need a Google Cloud account and a project with billing enabled.

## Step 1: Create Terraform configuration

First we need to create a vpc network for our project. Create a new directory and add a `main.tf` file with the following content:

```hcl
provider "google" {
  credentials = file("account.json")
  project     = "your-project-id"
  region      = "us-central1"
}


Create a new directory and add a `main.tf` file with the following content:

```hcl
provider "google" {
  credentials = file("account.json")
  project     = "your-project-id"
  region      = "us-central1"
}

resource "google_compute_instance" "nfs-server" {
  name         = "nfs-server"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = file("startup.sh")
}

resource "google_compute_firewall" "nfs-server" {
  name    = "nfs-server"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["2049"]
  }

  source_ranges = ["0.0.0.0/0"]
}
