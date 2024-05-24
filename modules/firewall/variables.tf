variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "target_tags" {
  description = "The target tags for the firewall rule"
  type        = list(string)
  default     = ["allow-ssh"]
}

variable "source_ranges" {
  description = "The source ranges for the firewall rule"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}