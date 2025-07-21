##
# main.tf
# This module creates GitHub related resources.
##

terraform {
  required_version = ">= 1.10.3"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6"
    }
  }
}

provider "github" {
  owner = "sosadtsia"
  token = var.github_token
}

# Using local state stored in tfstate directory
terraform {
  backend "local" {
    path = "tfstate/terraform.tfstate"
  }
}


data "github_user" "sosadtsia" {
  username = "sosadtsia"
}

# Configure GitHub Actions permissions for repositories
resource "github_actions_repository_permissions" "allow_actions" {
  for_each = { for key, repo in var.repositories : key => repo }

  repository      = each.value.name
  allowed_actions = "all"
  enabled         = true
}

module "github_repositories" {
  for_each = { for key, repo in var.repositories : key => repo }

  source = "./repositories"

  name        = each.value.name
  description = each.value.description

  repository_auto_init = each.value.repository_auto_init
  branch_deletion      = each.value.branch_deletion
  main_branch          = each.value.main_branch
  additional_branches  = each.value.additional_branches
  topics               = each.value.topics


  allow_auto_merge                = lookup(each.value, "allow_auto_merge", false)
  allow_update_branch             = lookup(each.value, "allow_update_branch", true)
  required_status_checks          = lookup(each.value, "required_status_checks", [])
  required_approving_review_count = lookup(each.value, "required_approving_review_count", 1)
  dismissal_restrictions          = lookup(each.value, "dismissal_restrictions", [data.github_user.sosadtsia.node_id])
  pull_request_bypassers          = lookup(each.value, "pull_request_bypassers", [data.github_user.sosadtsia.node_id])
}
