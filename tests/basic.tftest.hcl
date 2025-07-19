# Minimal test for GitHub Token authentication

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

  # GitHub token for authentication
  github_token = "mock-token"
}

run "basic_validation" {}
