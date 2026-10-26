variable "region" {
  description = "Volcengine region for the Provider."
  type        = string
  default     = "cn-beijing"
}

variable "vpc_id" {
  description = "ID of the existing VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "Existing public subnet IDs associated with the public ACL."
  type        = set(string)
}

variable "private_subnet_ids" {
  description = "Existing private subnet IDs associated with the private ACL."
  type        = set(string)
}

variable "database_subnet_ids" {
  description = "Existing database subnet IDs associated with the database ACL."
  type        = set(string)
}

variable "public_subnet_cidr" {
  description = "CIDR covering the public subnet tier."
  type        = string
  default     = "10.10.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR covering the private application subnet tier."
  type        = string
  default     = "10.10.11.0/24"
}

variable "database_subnet_cidr" {
  description = "CIDR covering the database subnet tier."
  type        = string
  default     = "10.10.21.0/24"
}
