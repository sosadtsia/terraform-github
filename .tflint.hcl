config {
  module = true
  force  = false
}

// Disallow deprecated (0.11-style) interpolation.
rule "terraform_deprecated_interpolation" {
  enabled = true
}

// Disallow variables, data sources, and locals that are declared but never
// used.
rule "terraform_unused_declarations" {
  enabled = true
}

// Disallow output declarations without description.
rule "terraform_documented_outputs" {
  enabled = true
}

// Disallow variables declarations without description.
rule "terraform_documented_variables" {
  enabled = true
}

// Disallow variable declarations without type.
rule "terraform_typed_variables" {
  enabled = true
}

// Disallow specifying a git or mercurial repository as a module source without
// pinning to a version.
rule "terraform_module_pinned_source" {
  enabled = true
}

// Enforces naming conventions for the following blocks: Resources, Input
// variables, Output values, Local values, Modules and Data sources.
rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

// Require that all OpenTofu/Terraform configurations have version constraints.
rule "terraform_required_version" {
  enabled = true
}

// Require that all providers have version constraints through
// required_providers or the provider version attribute.
rule "terraform_required_providers" {
  enabled = true
}
