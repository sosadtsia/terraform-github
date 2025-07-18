locals {
  files = {
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
}

resource "github_repository_file" "renovate-json5" {
  count = var.manage_files ? 1 : 0

  repository          = var.name
  branch             = "main"
  file               = local.files["renovate.json5"].path
  content            = file(local.files["renovate.json5"].source)
  commit_message     = "Add renovate configuration"
  overwrite_on_create = true

  # Ensure repository exists first
  depends_on = [github_repository.repository]
}

resource "github_repository_file" "call-ci-renovate" {
  count = var.manage_files ? 1 : 0

  repository          = var.name
  branch             = "main"
  file               = local.files["call-ci-renovate"].path
  content            = file(local.files["call-ci-renovate"].source)
  commit_message     = "Add CI renovate workflow"
  overwrite_on_create = true

  # Ensure repository exists first
  depends_on = [github_repository.repository]
}

resource "github_repository_file" "call-linter" {
  count = var.manage_files ? 1 : 0

  repository          = var.name
  branch             = "main"
  file               = local.files["call-linter"].path
  content            = file(local.files["call-linter"].source)
  commit_message     = "Add linter workflow"
  overwrite_on_create = true

  # Ensure repository exists first
  depends_on = [github_repository.repository]
}
