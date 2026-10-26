# BASIC NETWORK ACL Example

## 1. Overview

Runnable basic configuration for the NETWORK ACL module. It configures the provider from input variables and calls the published Registry module.

## 2. Usage

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. Examples

This directory is the basic example.

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
| `private_subnet_id` | Module-defined private_subnet_id. |
| `public_subnet_cidr` | Module-defined public_subnet_cidr. |

## 8. Outputs

| Name | Description |
|---|---|
| `network_acl_ids` | Module-defined network_acl_ids. |

## 9. Notes

- Supply credentials through supported provider configuration, never in source files.
- The final plan after apply must report no changes before the configuration is accepted.
