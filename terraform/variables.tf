variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "allowed_ssh_cidr" {
  description = "Your IP CIDR for SSH access"
  type        = string
}