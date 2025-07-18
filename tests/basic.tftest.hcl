# basic.tftest.hcl
# Simple test for terraform-github configuration

# Mock provider to avoid real GitHub API calls
mock_provider "github" {
  mock_resource "github_repository" {
    defaults = {
      full_name   = "sosadtsia/test-repo"
      repo_id     = 123456789
      html_url    = "https://github.com/sosadtsia/test-repo"
      http_clone_url = "https://github.com/sosadtsia/test-repo.git"
      ssh_clone_url  = "git@github.com:sosadtsia/test-repo.git"
      default_branch = "main"
    }
  }

  mock_resource "github_branch" {
    defaults = {
      id = "test-repo:develop"
      ref = "refs/heads/develop"
      sha = "abc123"
    }
  }

  mock_resource "github_branch_default" {
    defaults = {
      id = "test-repo"
    }
  }

  mock_resource "github_branch_protection" {
    defaults = {
      id = "test-repo:main"
    }
  }

  mock_data "github_repositories" {
    defaults = {
      names = ["repo1", "repo2"]
    }
  }

  mock_resource "github_repository_file" {
    defaults = {
      id = "test-repo/.github/renovate.json5"
      sha = "abc123"
    }
  }
}

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
        manage_files         = true
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
        manage_files         = true
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
        manage_files         = true
      }
    }
    github_token = "test-token"
  }

  # This should fail due to variable validation
  expect_failures = [
    var.repositories
  ]
}
