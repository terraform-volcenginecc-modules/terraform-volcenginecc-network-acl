variable "vpc_id" {
  description = "ID of the existing VPC that owns every managed network ACL. Changing it replaces every ACL."
  type        = string
  nullable    = false

  validation {
    condition     = trimspace(var.vpc_id) != ""
    error_message = "vpc_id must be a non-empty VPC ID."
  }
}

variable "common_tags" {
  description = "Tags applied to every network ACL. Per-ACL tags override matching keys."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition     = alltrue([for key in keys(var.common_tags) : trimspace(key) != ""])
    error_message = "common_tags keys must not be empty."
  }
}

variable "network_acls" {
  description = "Network ACLs keyed by stable logical names. Each ACL owns its inbound and outbound rules and its subnet associations."
  type = map(object({
    name                           = string
    description                    = optional(string, "")
    project_name                   = optional(string, "default")
    subnet_ids                     = optional(set(string), [])
    allow_public_management_access = optional(bool, false)
    tags                           = optional(map(string), {})
    ingress_rules = optional(map(object({
      cidr_ip     = string
      protocol    = string
      port_start  = optional(number, -1)
      port_end    = optional(number, -1)
      policy      = optional(string, "accept")
      name        = optional(string)
      description = optional(string, "")
    })), {})
    egress_rules = optional(map(object({
      cidr_ip     = string
      protocol    = string
      port_start  = optional(number, -1)
      port_end    = optional(number, -1)
      policy      = optional(string, "accept")
      name        = optional(string)
      description = optional(string, "")
    })), {})
  }))
  nullable = false

  validation {
    condition     = length(var.network_acls) > 0
    error_message = "network_acls must contain at least one ACL."
  }

  validation {
    condition = alltrue([
      for network_acl in values(var.network_acls) :
      length(network_acl.name) >= 1 &&
      length(network_acl.name) <= 128 &&
      can(regex("^[\\p{L}\\p{N}][\\p{L}\\p{N}._-]*$", network_acl.name))
    ])
    error_message = "Every ACL name must contain 1 to 128 supported characters and start with a letter or number."
  }

  validation {
    condition = alltrue([
      for network_acl in values(var.network_acls) :
      trimspace(network_acl.project_name) != ""
    ])
    error_message = "Every project_name must be non-empty."
  }

  validation {
    condition = alltrue([
      for network_acl in values(var.network_acls) :
      length(network_acl.description) <= 255
    ])
    error_message = "Every ACL description must be at most 255 characters."
  }

  validation {
    condition = alltrue(flatten([
      for network_acl in values(var.network_acls) : [
        for subnet_id in network_acl.subnet_ids : trimspace(subnet_id) != ""
      ]
    ]))
    error_message = "Every subnet_ids item must be a non-empty subnet ID."
  }

  validation {
    condition = alltrue(flatten([
      for network_acl in values(var.network_acls) : concat(
        [
          for rule_key, rule in network_acl.ingress_rules :
          trimspace(rule_key) != "" &&
          (rule.name == null ? true : trimspace(rule.name) != "") &&
          can(cidrhost(rule.cidr_ip, 0)) &&
          contains(["tcp", "udp", "icmp", "icmpv6", "gre", "all"], lower(rule.protocol)) &&
          contains(["accept", "drop"], lower(rule.policy)) &&
          (
            contains(["tcp", "udp"], lower(rule.protocol)) ?
            (rule.port_start >= 1 && rule.port_end <= 65535 && rule.port_start <= rule.port_end) :
            (rule.port_start == -1 && rule.port_end == -1)
          ) &&
          length(rule.description) <= 255
        ],
        [
          for rule_key, rule in network_acl.egress_rules :
          trimspace(rule_key) != "" &&
          (rule.name == null ? true : trimspace(rule.name) != "") &&
          can(cidrhost(rule.cidr_ip, 0)) &&
          contains(["tcp", "udp", "icmp", "icmpv6", "gre", "all"], lower(rule.protocol)) &&
          contains(["accept", "drop"], lower(rule.policy)) &&
          (
            contains(["tcp", "udp"], lower(rule.protocol)) ?
            (rule.port_start >= 1 && rule.port_end <= 65535 && rule.port_start <= rule.port_end) :
            (rule.port_start == -1 && rule.port_end == -1)
          ) &&
          length(rule.description) <= 255
        ]
      )
    ]))
    error_message = "Rule keys and names must be non-empty; CIDRs, protocols, policies, ports, and descriptions must satisfy the documented ACL rule constraints."
  }

  validation {
    condition = alltrue(flatten([
      for network_acl in values(var.network_acls) : [
        for key in keys(network_acl.tags) : trimspace(key) != ""
      ]
    ]))
    error_message = "Per-ACL tag keys must not be empty."
  }
}
