# basic.tftest.hcl
# Simple test for terraform-github configuration

run "valid_configuration" {
  command = plan

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
      }
    }
    github_token = "test-token"
  }

  # Test that variables are correctly set
  assert {
    condition     = length(var.repositories) == 1
    error_message = "Should have 1 repository configured"
  }

  assert {
    condition     = var.repositories.test_repo.name == "test-repo"
    error_message = "Repository name should be 'test-repo'"
  }

  assert {
    condition     = var.repositories.test_repo.main_branch == "main"
    error_message = "Main branch should be 'main'"
  }
}

# Test that invalid repository name fails validation
run "invalid_repository_name" {
  command = plan

  variables {
    repositories = {
      invalid_repo = {
        name                 = "invalid@repo!"  # Contains invalid characters
        description          = "Test repository"
        repository_auto_init = true
        branch_deletion      = true
        main_branch          = "main"
        additional_branches  = []
        topics               = []
      }
    }
    github_token = "test-token"
  }

  # This should fail due to variable validation
  expect_failures = [
    var.repositories
  ]
}

# Test that invalid main branch fails validation
run "invalid_main_branch" {
  command = plan

  variables {
    repositories = {
      test_repo = {
        name                 = "test-repo"
        description          = "Test repository"
        repository_auto_init = true
        branch_deletion      = true
        main_branch          = "invalid-branch"  # Not in allowed list
        additional_branches  = []
        topics               = []
      }
    }
    github_token = "test-token"
  }

  # This should fail due to variable validation
  expect_failures = [
    var.repositories
  ]
}
