# Changelog

## [Unreleased]

### Added

- Initial Network ACL module with subnet association, ingress rules, egress
  rules, and tags.
- Basic and complete examples.
- Chinese real-cloud validation report.

### Fixed

- Handle optional rule names, empty subnet associations, and null association
  outputs without plan drift or output failures.

### Verified

- Real-cloud basic and complete lifecycle validation with Terraform `1.5.7`
  and Registry Provider `volcengine/volcenginecc v0.0.70`.
