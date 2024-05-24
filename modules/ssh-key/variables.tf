variable "file_path" {
  type = string
  description = "The path to the file where the private key will be saved"
  default = ".ssh/google_compute_engine"
}

variable "file_permission" {
  type = number
  description = "The permission of the file where the private key will be saved"
  default = 0600
}