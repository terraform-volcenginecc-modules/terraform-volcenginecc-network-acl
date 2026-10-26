variable "region" {
  description = "Volcengine region for the Provider."
  type        = string
  default     = "cn-beijing"
}

variable "vpc_id" {
  description = "ID of the existing VPC."
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the existing private subnet associated with the ACL."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR of the trusted public subnet allowed to reach the application."
  type        = string
  default     = "10.10.1.0/24"
}
