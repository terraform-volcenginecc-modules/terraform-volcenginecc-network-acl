# COMPLETE NETWORK ACL 示例

## 1. 概述

NETWORK ACL 模块的可运行 complete 配置。它从输入变量设置 Provider，并调用已发布的 Registry 模块。

## 2. 用法

```shell
terraform init
terraform plan
terraform apply
terraform plan
terraform destroy
```

## 3. 示例

本目录即为 complete 示例。

## 4. 版本要求

| 名称 | 版本 |
|---|---|
| Terraform | `>= 1.5.7` |
| OpenTofu | `>= 1.11.8` |

## 5. Provider

| 名称 | 来源 |
|---|---|
| `volcenginecc` | `volcengine/volcenginecc` |

## 6. 资源

| 名称 | 说明 |
|---|---|
| `terraform-volcenginecc-modules/network-acl/volcenginecc` | 已发布的 NETWORK ACL 模块。 |

## 7. 输入

| 名称 | 说明 |
|---|---|
| `region` | 模块定义的 region。 |
| `vpc_id` | 模块定义的 vpc_id。 |
| `public_subnet_ids` | 模块定义的 public_subnet_ids。 |
| `private_subnet_ids` | 模块定义的 private_subnet_ids。 |
| `database_subnet_ids` | 模块定义的 database_subnet_ids。 |
| `public_subnet_cidr` | 模块定义的 public_subnet_cidr。 |
| `private_subnet_cidr` | 模块定义的 private_subnet_cidr。 |
| `database_subnet_cidr` | 模块定义的 database_subnet_cidr。 |

## 8. 输出

| 名称 | 说明 |
|---|---|
| `network_acl_ids` | 模块定义的 network_acl_ids。 |
| `network_acls` | 模块定义的 network_acls。 |

## 9. 注意事项

- 请通过 Provider 支持的配置提供凭据，绝不应写入源文件。
- apply 后的最终 plan 必须报告无变更，才能接受该配置。
