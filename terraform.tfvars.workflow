##
# terraform.tfvars.workflow
# Safe configuration for GitHub Actions workflow
##

repositories = {
  workflow_test = {
    name                 = "workflow-test-repo"
    description          = "Test repository created by GitHub Actions workflow"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = []
    topics               = ["test", "github-actions", "workflow"]
  }
}
