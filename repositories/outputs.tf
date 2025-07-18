/**
 * outputs.tf
 * Provides output variables for the module. Typically outputs names,
 * identifiers, ARNs that are dynamically created and would be required for
 * other modules or connectivity with something else (such as unit tests).
 */

output "repository_name" {
  description = "The name of the created repository"
  value       = github_repository.repository.name
}

output "repository_full_name" {
  description = "The full name of the created repository (owner/name)"
  value       = github_repository.repository.full_name
}

output "repository_id" {
  description = "The ID of the created repository"
  value       = github_repository.repository.repo_id
}

output "repository_url" {
  description = "The URL of the created repository"
  value       = github_repository.repository.html_url
}

output "repository_clone_url" {
  description = "The clone URL of the created repository"
  value       = github_repository.repository.http_clone_url
}

output "repository_ssh_clone_url" {
  description = "The SSH clone URL of the created repository"
  value       = github_repository.repository.ssh_clone_url
}

output "default_branch" {
  description = "The default branch of the repository"
  value       = github_branch_default.default.branch
}

output "protected_branches" {
  description = "List of protected branches"
  value       = [for branch in github_branch_protection.protection : branch.pattern]
}
