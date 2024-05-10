## Instructions

### Pre-requisites

The follwing packages need to be installed before creating the HPC infrastructure and environment setup.

- [Google Cloud CLI](https://cloud.google.com/sdk/docs/install)
- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 

After installing all packages, run the following commando to connect to GCP:

```sh
gcloud init
```

### Create HPC environment in GCP

Simply run:

```sh
terraform apply
```

