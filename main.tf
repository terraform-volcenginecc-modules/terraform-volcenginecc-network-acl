locals {
  normalized_network_acls = {
    for key, network_acl in var.network_acls : key => {
      network_acl_name               = network_acl.name
      description                    = network_acl.description
      project_name                   = network_acl.project_name
      subnet_ids                     = network_acl.subnet_ids
      ingress_rules                  = network_acl.ingress_rules
      egress_rules                   = network_acl.egress_rules
      tags                           = merge(var.common_tags, network_acl.tags)
      allow_public_management_access = network_acl.allow_public_management_access
    }
  }
}

resource "volcenginecc_vpc_network_acl" "this" {
  for_each = local.normalized_network_acls

  vpc_id           = var.vpc_id
  network_acl_name = each.value.network_acl_name
  description      = each.value.description
  project_name     = each.value.project_name

  ingress_acl_entries = [
    for rule_key in sort(keys(each.value.ingress_rules)) : {
      cidr_ip                = each.value.ingress_rules[rule_key].cidr_ip
      description            = each.value.ingress_rules[rule_key].description
      network_acl_entry_name = coalesce(each.value.ingress_rules[rule_key].name, rule_key)
      policy                 = lower(each.value.ingress_rules[rule_key].policy)
      port                   = "${each.value.ingress_rules[rule_key].port_start}/${each.value.ingress_rules[rule_key].port_end}"
      protocol               = lower(each.value.ingress_rules[rule_key].protocol)
    }
  ]

  egress_acl_entries = [
    for rule_key in sort(keys(each.value.egress_rules)) : {
      cidr_ip                = each.value.egress_rules[rule_key].cidr_ip
      description            = each.value.egress_rules[rule_key].description
      network_acl_entry_name = coalesce(each.value.egress_rules[rule_key].name, rule_key)
      policy                 = lower(each.value.egress_rules[rule_key].policy)
      port                   = "${each.value.egress_rules[rule_key].port_start}/${each.value.egress_rules[rule_key].port_end}"
      protocol               = lower(each.value.egress_rules[rule_key].protocol)
    }
  ]

  resources = length(each.value.subnet_ids) == 0 ? null : [
    for subnet_id in sort(tolist(each.value.subnet_ids)) : {
      resource_id = subnet_id
    }
  ]

  tags = length(each.value.tags) == 0 ? null : [
    for tag_key in sort(keys(each.value.tags)) : {
      key   = tag_key
      value = each.value.tags[tag_key]
    }
  ]

  lifecycle {
    precondition {
      condition = each.value.allow_public_management_access || !anytrue([
        for rule in values(each.value.ingress_rules) :
        lower(rule.policy) == "accept" &&
        contains(["0.0.0.0/0", "::/0"], rule.cidr_ip) &&
        (
          lower(rule.protocol) == "all" ||
          (
            lower(rule.protocol) == "tcp" &&
            (
              (rule.port_start <= 22 && rule.port_end >= 22) ||
              (rule.port_start <= 3389 && rule.port_end >= 3389)
            )
          )
        )
      ])
      error_message = "Public SSH (22) or RDP (3389) ingress requires allow_public_management_access to be true for the ACL."
    }
  }
}
