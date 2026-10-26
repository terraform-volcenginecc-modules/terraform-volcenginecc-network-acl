output "network_acl_ids" {
  description = "Created network ACL IDs keyed by logical name."
  value       = module.network_acl.network_acl_ids
}
