# Terraform GitHub Repository Management

This repository uses OpenTofu/Terraform to manage GitHub repositories and their configurations, including branch protection rules, workflows, and repository files.

## Features

- **Repository Management**: Create and configure GitHub repositories with consistent settings
- **Branch Protection**: Enforce branch protection rules with required reviews and status checks
- **Automated File Management**: Deploy standard files (LICENSE, README, workflows) across repositories
- **Renovate Integration**: Automatic dependency updates with Renovate bot
- **Security Scanning**: Integrated Gitleaks for secret detection

## Prerequisites

- [OpenTofu](https://opentofu.org/) >= 1.10.3 or [Terraform](https://www.terraform.io/) >= 1.10.3
- GitHub Personal Access Token with repository creation permissions
- Access to the GitHub organization/user account

## Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/sosadtsia/terraform-github.git
   cd terraform-github
   ```

2. **Configure your GitHub token**:
   ```bash
   export TF_VAR_github_token="your-github-token"
   ```

3. **Initialize Terraform**:
   ```bash
   tofu init
   ```

4. **Review and customize `terraform.tfvars`**:
   ```hcl
   repositories = {
     example_repo = {
       name                   = "example-repository"
       description            = "An example repository"
       repository_auto_init   = true
       branch_deletion        = true
       main_branch            = "main"
       additional_branches    = ["develop", "staging"]
       topics                 = ["terraform", "example"]
     }
   }
   ```

## Authentication

### Personal Access Token (Recommended)

This repository is configured to use a GitHub Personal Access Token (PAT) for authentication:

1. Create a GitHub PAT at https://github.com/settings/tokens
2. Ensure it has the `repo` scope (full control of private repositories)
3. Set it as an environment variable:
   ```bash
   export TF_VAR_github_token="your-github-token"
   ```

For CI/CD workflows:
1. Add a repository secret named `GH_PAT` containing your GitHub Personal Access Token
2. The workflow automatically uses this for authentication

### Security Best Practices

- Use tokens with the minimum required permissions
- Set an appropriate expiration date (90 days recommended)
- Store tokens securely in environment variables or secrets
- Never commit tokens to the repository
- Rotate tokens regularly

## Usage

### Basic Operations

```bash
# Plan changes
tofu plan

# Apply changes
tofu apply

# Destroy resources (use with caution)
tofu destroy
```

### Repository Configuration

The `repositories` variable accepts the following configuration:

```hcl
repositories = {
  repository_key = {
    # Required fields
    name                   = "repository-name"
    description            = "Repository description"
    repository_auto_init   = true
    branch_deletion        = true
    main_branch            = "main"
    additional_branches    = ["develop", "staging"]
    topics                 = ["topic1", "topic2"]

    # Optional fields (with defaults)
    allow_auto_merge                = false
    required_status_checks          = ["ci/build", "ci/test"]
    required_approving_review_count = 1
    dismissal_restrictions          = ["team1", "team2"]
    pull_request_bypassers         = ["admin-team"]
  }
}
```

### Branch Protection Features

- **Required Reviews**: Configurable number of required approving reviews
- **Status Checks**: Enforce CI/CD pipeline success before merging
- **Dismissal Restrictions**: Control who can dismiss pull request reviews
- **Admin Enforcement**: Apply rules to administrators
- **Force Push Protection**: Prevent force pushes to protected branches

## Repository File Management

This configuration automatically manages repository files (like renovate config and CI workflows) with proper dependency ordering:

### Dependency Order
1. **Repository Creation**: GitHub repositories are created first
2. **Branch Protection**: Branch protection rules are applied
3. **Repository Files**: Files are added to repositories last (only if `manage_files = true`)

### Managed Files
- `.github/renovate.json5` - Renovate configuration
- `.github/workflows/call-ci-renovate.yaml` - CI workflow for Renovate
- `.github/workflows/call-linter.yaml` - Linting workflow

### Configuration Options

```hcl
repositories = {
  "my-repo" = {
    name = "my-repo"
    description = "My repository"
    # ... other settings ...

    # Control file management
    manage_files = true  # Default: true
  }
}
```

### File Management Control

- `manage_files = true`: Repository files will be created/updated
- `manage_files = false`: Skip file management for this repository

This ensures that:
- Files are only added to repositories that exist
- Repository structure is established before files are added
- You can selectively control which repositories get managed files

## Terraform State Management

## Module Structure

```
├── main.tf                 # Main configuration and provider setup
├── variables.tf            # Input variables
├── terraform.tfvars        # Variable values (customize for your needs)
├── tfstate/                # Terraform state files
│   ├── .gitkeep           # Ensures directory structure in git
│   └── terraform.tfstate  # State file (committed by CI/CD)
├── repositories/           # Repository management module
│   ├── main.tf            # Module requirements
│   ├── variables.tf       # Module variables
│   ├── repository.tf      # Repository resources
│   ├── repository-files.tf # File management
│   └── outputs.tf         # Module outputs
├── tests/                 # Test files
│   ├── README.md          # Testing documentation
│   └── basic.tftest.hcl   # Basic configuration tests
├── files/                 # Template files for repositories
│   ├── LICENSE           # Apache 2.0 License
│   ├── README.md         # Template README
│   └── renovate-config/  # Renovate configuration files
└── .github/
    └── workflows/        # CI/CD workflows
```

## Testing

The repository includes a comprehensive test suite:

```bash
# Run all tests
tofu test

# Run specific test file
tofu test tests/basic.tftest.hcl

# Run with verbose output
tofu test -verbose
```

### Test Coverage

- ✅ Configuration validation
- ✅ Variable validation rules
- ✅ Input parameter validation
- ✅ Error handling for invalid inputs

See [tests/README.md](tests/README.md) for detailed testing documentation.

## CI/CD Integration

The repository includes GitHub Actions workflows for:

- **Terraform Planning**: Automated planning on pull requests
- **Resource Creation**: Apply changes on main branch using PAT authentication
- **Testing**: Automated test execution on code changes
- **Linting**: Code quality checks with tflint
- **Security Scanning**: Secret detection with Gitleaks
- **Dependency Updates**: Automated updates with Renovate

## Security Considerations

- **Token Security**: Use a GitHub PAT with appropriate permissions and expiration
- **State Management**: State file is committed to repository by CI/CD workflow (consider remote backend for production)
- **Secret Scanning**: Gitleaks integration prevents accidental secret commits
- **Branch Protection**: All protected branches require review and status checks

## Troubleshooting

### Common Issues

1. **Token Permissions**: Ensure your GitHub PAT has the `repo` scope for full repository access
2. **State Management**: State file is automatically committed by CI/CD workflow
3. **Concurrent Runs**: Use the concurrency group to prevent simultaneous runs
4. **Provider Version**: Ensure you're using compatible provider versions

### Authentication Issues

If you encounter authentication errors:

1. **Check Token Expiration**: Ensure your PAT hasn't expired
2. **Verify Permissions**: Confirm the token has repo scope
3. **Secret Configuration**: Make sure the `GH_PAT` secret is properly set in your repository
4. **Environment Variables**: Verify `TF_VAR_github_token` is properly set when running locally

### Validation

```bash
# Check configuration syntax
tofu validate

# Format code
tofu fmt

# Run tests
tofu test

# Run security scan
gitleaks detect --source . --verbose
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and validation
5. Submit a pull request

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.

## Support

For issues and questions:
- Create an issue in this repository
- Review the troubleshooting section
- Check the Terraform GitHub provider documentation
