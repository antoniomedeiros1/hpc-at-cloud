variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vm_image" {
  description = "The image to use for the VM"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"  
}

variable "public_key_openssh" {
  description = "The public key to use for the VM instance"
  type = string
}