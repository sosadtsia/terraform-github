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
- GitHub Personal Access Token or GitHub App with repository administration permissions
- Access to the GitHub organization/user account

## Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/sosadtsia/terraform-github.git
   cd terraform-github
   ```

2. **Configure your GitHub token**:
   ```bash
   export GH_TOKEN="your-github-token"
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

## Module Structure

```
├── main.tf                 # Main configuration and provider setup
├── variables.tf            # Input variables
├── terraform.tfvars        # Variable values (customize for your needs)
├── tfstate/                # Terraform state files (gitignored)
│   └── .gitkeep           # Ensures directory structure in git
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
- **Resource Creation**: Apply changes on main branch
- **Testing**: Automated test execution on code changes
- **Linting**: Code quality checks with tflint
- **Security Scanning**: Secret detection with Gitleaks
- **Dependency Updates**: Automated updates with Renovate

## Security Considerations

- **Token Security**: Use GitHub Apps instead of personal access tokens when possible
- **State Management**: Uses local state stored in `tfstate/` directory (consider remote backend for production)
- **Secret Scanning**: Gitleaks integration prevents accidental secret commits
- **Branch Protection**: All protected branches require review and status checks

## Troubleshooting

### Common Issues

1. **Token Permissions**: Ensure your GitHub token has `repo` and `admin:org` permissions
2. **State Management**: Currently uses local state; for production consider remote backend
3. **Concurrent Runs**: Use the concurrency group to prevent simultaneous runs
4. **Provider Version**: Ensure you're using compatible provider versions

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
