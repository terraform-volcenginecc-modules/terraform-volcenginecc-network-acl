provider "volcenginecc" {
  region = var.region
}

module "network_acl" {
  source  = "terraform-volcenginecc-modules/network-acl/volcenginecc"
  version = "~> 1.0"

  vpc_id = var.vpc_id

  network_acls = {
    private = {
      name        = "basic-private-acl"
      description = "Private subnet application ACL"
      subnet_ids  = [var.private_subnet_id]

      ingress_rules = {
        application_from_public = {
          cidr_ip     = var.public_subnet_cidr
          protocol    = "tcp"
          port_start  = 8080
          port_end    = 8080
          description = "Application traffic from the public subnet"
        }
      }

      egress_rules = {
        application_return = {
          cidr_ip     = var.public_subnet_cidr
          protocol    = "tcp"
          port_start  = 1024
          port_end    = 65535
          description = "Return traffic to the public subnet"
        }
      }
    }
  }

  common_tags = {
    Environment = "example"
    ManagedBy   = "Terraform"
    Scenario    = "private-subnet-acl"
  }
}
