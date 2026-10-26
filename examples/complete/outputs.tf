output "network_acl_ids" {
  description = "Created network ACL IDs keyed by tier."
  value       = module.network_acl.network_acl_ids
}

output "network_acls" {
  description = "Created network ACL details, including cloud default rules."
  value       = module.network_acl.network_acls
}
