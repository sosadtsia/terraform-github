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

  # GitHub App authentication
  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_pem_file
  }
}

# Using local state stored in tfstate directory
terraform {
  backend "local" {
    path = "tfstate/terraform.tfstate"
  }
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
  required_status_checks          = lookup(each.value, "required_status_checks", [])
  required_approving_review_count = lookup(each.value, "required_approving_review_count", 1)
  dismissal_restrictions          = lookup(each.value, "dismissal_restrictions", [])
  pull_request_bypassers          = lookup(each.value, "pull_request_bypassers", [])
}
