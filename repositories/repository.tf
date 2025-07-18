/**
 * repository.tf
 * Creates the GitHub repository along with branches and branch protection
 * rules.
 */

locals {
  branches = toset(concat([var.main_branch], var.additional_branches))
  non_default_branches = toset(var.additional_branches)
}

resource "github_repository" "repository" {
  name        = var.name
  description = var.description
  visibility  = "public"
  auto_init   = var.repository_auto_init
  topics      = var.topics

  allow_auto_merge       = var.allow_auto_merge
  delete_branch_on_merge = var.delete_branch_on_merge
}

resource "github_branch" "additional_branches" {
  for_each = local.non_default_branches

  repository    = github_repository.repository.name
  branch        = each.value
  source_branch = var.main_branch
}

resource "github_branch_default" "default" {
  repository = github_repository.repository.name
  branch     = var.main_branch
}

resource "github_branch_protection" "protection" {
  for_each = local.branches

  repository_id    = github_repository.repository.name
  pattern          = each.value
  allows_deletions = var.branch_deletion

  enforce_admins      = false
  allows_force_pushes = false

  required_pull_request_reviews {
    require_code_owner_reviews = true
    dismiss_stale_reviews      = true
    restrict_dismissals        = true

    required_approving_review_count = var.required_approving_review_count
    require_last_push_approval      = true

    dismissal_restrictions = var.dismissal_restrictions
    pull_request_bypassers = var.pull_request_bypassers
  }

  required_status_checks {
    strict   = true
    contexts = var.required_status_checks
  }

  depends_on = [
    github_branch.additional_branches,
    github_branch_default.default
  ]
}
