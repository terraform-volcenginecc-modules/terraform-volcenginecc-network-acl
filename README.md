# terraform-volcenginecc-network-acl

## 1. Overview

Terraform module for managing Volcengine NETWORK ACL resources with the `volcenginecc` provider. The caller owns provider authentication, region configuration, and external resources passed by ID.

## 2. Usage

```hcl
module "network_acl" {
  source  = "terraform-volcenginecc-modules/network-acl/volcenginecc"
  version = "~> 1.0"

  # Set the required module inputs for your environment.
}
```

## 3. Examples

- `basic`: independently runnable basic configuration.
- `complete`: independently runnable complete configuration.

## 4. Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 5. Providers

| Name | Source |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 6. Resources

| Name | Description |
|---|---|
| `volcenginecc_vpc_network_acl` | Module-defined volcenginecc_vpc_network_acl. |

## 7. Inputs

| Name | Description |
|---|---|
| `vpc_id` | Module-defined vpc_id. |
| `common_tags` | Module-defined common_tags. |
| `network_acls` | Module-defined network_acls. |

## 8. Outputs

| Name | Description |
|---|---|
| `network_acl_ids` | Module-defined network_acl_ids. |
| `network_acls` | Module-defined network_acls. |

## 9. Notes

- Configure credentials using supported provider mechanisms; do not put access keys in module files.
- Review replacement behavior and provider constraints before applying changes.
- Run `terraform plan` after apply and confirm that the second plan has no changes.
