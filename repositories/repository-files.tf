locals {
  renovate_files = {
    "renovate.json5" = {
      path    = ".github/renovate.json5"
      source  = "${path.root}/files/renovate-config/.github/renovate.json5"
    }
    "call-ci-renovate" = {
      path    = ".github/workflows/call-ci-renovate.yaml"
      source  = "${path.root}/files/renovate-config/.github/workflows/call-ci-renovate.yaml"
    }
    "call-linter" = {
      path    = ".github/workflows/call-linter.yaml"
      source  = "${path.root}/files/renovate-config/.github/workflows/call-linter.yaml"
    }
  }
  repos_list = data.github_repositories.repos.names
}

data "github_repositories" "repos" {
  query = "user:sosadtsia"
  include_repo_id = true
}

resource "github_repository_file" "renovate-json5" {
  for_each = toset(local.repos_list)

  repository          = each.value
  branch             = "main"
  file               = local.renovate_files["renovate.json5"].path
  content            = file(local.renovate_files["renovate.json5"].source)
  commit_message     = "Update ${each.key} configuration"
  overwrite_on_create = true
}

resource "github_repository_file" "call-ci-renovate" {
  for_each = toset(local.repos_list)

  repository          = each.value
  branch             = "main"
  file               = local.renovate_files["call-ci-renovate"].path
  content            = file(local.renovate_files["call-ci-renovate"].source)
  commit_message     = "Update ${each.key} configuration"
  overwrite_on_create = true
}
