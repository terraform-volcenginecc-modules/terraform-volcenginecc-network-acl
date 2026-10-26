provider "volcenginecc" {
  region = var.region
}

module "network_acl" {
  source  = "terraform-volcenginecc-modules/network-acl/volcenginecc"
  version = "~> 1.0"

  vpc_id = var.vpc_id

  network_acls = {
    public = {
      name        = "complete-public-acl"
      description = "Public subnet web ingress ACL"
      subnet_ids  = var.public_subnet_ids

      ingress_rules = {
        deny_admin_from_internet = {
          cidr_ip     = "0.0.0.0/0"
          protocol    = "tcp"
          port_start  = 22
          port_end    = 22
          policy      = "drop"
          description = "Deny direct SSH from the Internet"
        }
        allow_http = {
          cidr_ip     = "0.0.0.0/0"
          protocol    = "tcp"
          port_start  = 80
          port_end    = 80
          description = "Allow public HTTP"
        }
        allow_https = {
          cidr_ip     = "0.0.0.0/0"
          protocol    = "tcp"
          port_start  = 443
          port_end    = 443
          description = "Allow public HTTPS"
        }
      }

      egress_rules = {
        return_to_internet = {
          cidr_ip     = "0.0.0.0/0"
          protocol    = "tcp"
          port_start  = 1024
          port_end    = 65535
          description = "Allow return traffic to web clients"
        }
        application_to_private = {
          cidr_ip     = var.private_subnet_cidr
          protocol    = "tcp"
          port_start  = 8080
          port_end    = 8080
          description = "Forward requests to private application subnets"
        }
      }
    }

    private = {
      name        = "complete-private-acl"
      description = "Private subnet application ACL"
      subnet_ids  = var.private_subnet_ids

      ingress_rules = {
        application_from_public = {
          cidr_ip     = var.public_subnet_cidr
          protocol    = "tcp"
          port_start  = 8080
          port_end    = 8080
          description = "Allow application traffic from public subnets"
        }
      }

      egress_rules = {
        return_to_public = {
          cidr_ip     = var.public_subnet_cidr
          protocol    = "tcp"
          port_start  = 1024
          port_end    = 65535
          description = "Allow return traffic to public subnets"
        }
        mysql_to_database = {
          cidr_ip     = var.database_subnet_cidr
          protocol    = "tcp"
          port_start  = 3306
          port_end    = 3306
          description = "Allow MySQL access to database subnets"
        }
      }
    }

    database = {
      name        = "complete-database-acl"
      description = "Database subnet isolation ACL"
      subnet_ids  = var.database_subnet_ids

      ingress_rules = {
        deny_rdp_from_internet = {
          cidr_ip     = "0.0.0.0/0"
          protocol    = "tcp"
          port_start  = 3389
          port_end    = 3389
          policy      = "drop"
          description = "Deny direct RDP from the Internet"
        }
        mysql_from_private = {
          cidr_ip     = var.private_subnet_cidr
          protocol    = "tcp"
          port_start  = 3306
          port_end    = 3306
          description = "Allow MySQL from private application subnets"
        }
      }

      egress_rules = {
        mysql_return_to_private = {
          cidr_ip     = var.private_subnet_cidr
          protocol    = "tcp"
          port_start  = 1024
          port_end    = 65535
          description = "Allow database return traffic to private subnets"
        }
      }
    }
  }

  common_tags = {
    Environment = "example"
    ManagedBy   = "Terraform"
    Scenario    = "tiered-network-acl"
  }
}
