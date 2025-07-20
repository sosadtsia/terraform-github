# Terraform GitHub Repository Management

Manage GitHub repositories with OpenTofu/Terraform - automate creation, branch protection, and standardized files.

## Prerequisites

- OpenTofu/Terraform ≥ 1.10.3
- GitHub PAT with repo scope
- [Go Task](https://taskfile.dev/)
- [TFLint](https://github.com/terraform-linters/tflint)

## Quick Start

```bash
# Clone repo
git clone https://github.com/sosadtsia/terraform-github.git && cd terraform-github

# Set token
export TF_VAR_github_token="your-github-token"

# Initialize and verify
task init
task verify

# Apply changes
task plan
task apply
```

## Authentication

- Create a GitHub PAT with `repo` scope at https://github.com/settings/tokens
- Set locally: `export TF_VAR_github_token="your-token"`
- For CI/CD: Add secret named `GH_PAT`

## Available Tasks

```bash
task --list        # List all tasks
task init          # Initialize project
task fmt           # Format code
task validate      # Validate configuration
task lint          # Run TFLint checks
task test          # Run tests
task verify        # Run all checks
task plan          # Generate plan
task apply         # Apply changes
task destroy       # Destroy resources
```

## Configuration

Define repositories in `terraform.tfvars`:

```hcl
repositories = {
  example_repo = {
    name                 = "example-repo"
    description          = "Example repository"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["develop"]
    topics               = ["api", "example"]
    manage_files         = true
  }
}
```

## Repository Structure

```
├── main.tf                 # Provider configuration
├── variables.tf            # Input variable definitions
├── terraform.tfvars        # Repository configurations
├── Taskfile.yml           # Task definitions
├── .tflint.hcl            # TFLint rules
├── repositories/           # Repository module
├── tests/                 # Test definitions
└── files/                 # Template files
```

## CI/CD

Add `GH_PAT` as repository secret with repo scope for GitHub Actions workflow.

## Troubleshooting

- **Auth Issues**: Check PAT expiration and permissions
- **State Issues**: State files are auto-committed by CI/CD
- **Validation Errors**: Run `task verify` to identify issues

## License

Apache 2.0 - See [LICENSE](LICENSE) for details.
