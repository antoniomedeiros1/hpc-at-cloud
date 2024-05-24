variable "project_id" {
  description = "The project ID to deploy the resources"
}

variable "region" {
  description = "The region to deploy the resources"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
  
}