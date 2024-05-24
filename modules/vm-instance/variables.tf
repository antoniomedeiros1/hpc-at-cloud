variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "instance_name" {
  description = "The name of the VM instance"
  type        = string
  default     = "my-vm"
}

variable "instance_type" {
  description = "The type of the VM instance"
  type        = string
  default     = "n2-standard-2"
}

variable "instance_zone" {
  description = "The zone of the VM instance"
  type        = string
  default     = "us-central1-a"
}

variable vm_image {
  description = "The image to use for the VM"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "public_key_openssh" {
  description = "The public key to use for the VM instance"
  type = string
}