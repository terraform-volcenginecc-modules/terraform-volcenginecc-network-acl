# COMPLETE NETWORK ACL Example

## 1. Overview

Runnable complete configuration for the NETWORK ACL module. It configures the provider from input variables and calls the published Registry module.

## 2. Usage

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. Examples

This directory is the complete example.

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
| `terraform-volcenginecc-modules/network-acl/volcenginecc` | Published NETWORK ACL module. |

## 7. Inputs

| Name | Description |
|---|---|
| `region` | Module-defined region. |
| `vpc_id` | Module-defined vpc_id. |
| `public_subnet_ids` | Module-defined public_subnet_ids. |
| `private_subnet_ids` | Module-defined private_subnet_ids. |
| `database_subnet_ids` | Module-defined database_subnet_ids. |
| `public_subnet_cidr` | Module-defined public_subnet_cidr. |
| `private_subnet_cidr` | Module-defined private_subnet_cidr. |
| `database_subnet_cidr` | Module-defined database_subnet_cidr. |

## 8. Outputs

| Name | Description |
|---|---|
| `network_acl_ids` | Module-defined network_acl_ids. |
| `network_acls` | Module-defined network_acls. |

## 9. Notes

- Supply credentials through supported provider configuration, never in source files.
- The final plan after apply must report no changes before the configuration is accepted.
