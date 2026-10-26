output "network_acl_ids" {
  description = "Map of stable ACL logical keys to network ACL IDs."
  value = {
    for key, network_acl in volcenginecc_vpc_network_acl.this : key => network_acl.network_acl_id
  }
}

output "network_acls" {
  description = "Managed ACL details keyed by stable logical name. Default rules and rule priority are cloud-generated read-only values."
  value = {
    for key, network_acl in volcenginecc_vpc_network_acl.this : key => {
      id                          = network_acl.network_acl_id
      name                        = network_acl.network_acl_name
      vpc_id                      = network_acl.vpc_id
      project_name                = network_acl.project_name
      status                      = network_acl.status
      associated_subnet_ids       = toset([for resource in coalesce(network_acl.resources, []) : resource.resource_id])
      default_ingress_acl_entries = network_acl.default_ingress_acl_entries
      default_egress_acl_entries  = network_acl.default_egress_acl_entries
      tags = network_acl.tags == null ? tomap({}) : tomap({
        for tag in network_acl.tags : tag.key => tag.value == null ? "" : tag.value
      })
    }
  }
}
