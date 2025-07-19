# Minimal test for GitHub App authentication

# Use built-in mocking
mock_provider "github" {}

variables {
  repositories = {
    test_repo = {
      name                 = "test-repo"
      description          = "Test repository"
      repository_auto_init = true
      branch_deletion      = true
      main_branch          = "main"
      additional_branches  = ["develop"]
      topics               = ["terraform", "test"]
      manage_files         = true
    }
  }

  # GitHub App authentication variables
  github_app_id = "mock-app-id"
  github_app_installation_id = "mock-installation-id"
  github_app_pem_file = "mock-pem-file"
}

run "basic_validation" {}
