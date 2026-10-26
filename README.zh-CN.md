# terraform-volcenginecc-network-acl

## 1. 概述

基于 `volcenginecc` Provider 管理火山引擎 NETWORK ACL 资源的 Terraform 模块。调用方负责 Provider 凭据、地域配置，以及通过 ID 传入的外部资源。

## 2. 用法

```hcl
module "network_acl" {
  source  = "terraform-volcenginecc-modules/network-acl/volcenginecc"
  version = "~> 1.0"

  # 请设置适用于当前环境的必填模块输入。
}
```

## 3. 示例

- `basic`：可独立运行的 basic 配置。
- `complete`：可独立运行的 complete 配置。

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
| `volcenginecc_vpc_network_acl` | 模块定义的 volcenginecc_vpc_network_acl。 |

## 7. 输入

| 名称 | 说明 |
|---|---|
| `vpc_id` | 模块定义的 vpc_id。 |
| `common_tags` | 模块定义的 common_tags。 |
| `network_acls` | 模块定义的 network_acls。 |

## 8. 输出

| 名称 | 说明 |
|---|---|
| `network_acl_ids` | 模块定义的 network_acl_ids。 |
| `network_acls` | 模块定义的 network_acls。 |

## 9. 注意事项

- 请通过 Provider 支持的方式配置凭据，不要将访问密钥写入模块文件。
- 执行变更前请审阅替换行为及 Provider 限制。
- apply 后请再次执行 `terraform plan`，并确认第二次 plan 无变更。
