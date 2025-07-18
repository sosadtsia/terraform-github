# Terraform State Backups

This directory contains automated backups of the Terraform state file created by the GitHub Actions workflow.

## Backup System

- **Automatic Creation**: Backups are created before each `tofu apply` operation
- **Timestamp Format**: `terraform.tfstate.backup_YYYYMMDD_HHMMSS`
- **Retention Policy**: Only the last 5 backups are kept to avoid repository bloat
- **Failure Recovery**: If `tofu apply` fails, the workflow automatically restores from the latest backup

## Manual Restore

To manually restore from a backup:

```bash
# List available backups
ls -la tfstate/backups/

# Restore from specific backup
cp tfstate/backups/terraform.tfstate.backup_YYYYMMDD_HHMMSS tfstate/terraform.tfstate

# Verify restored state
tofu validate
tofu state list
```

## Backup Validation

Each backup undergoes the same validation as the main state file:
- JSON format validation
- Resource count verification
- Configuration consistency checks

## Security Note

Backups may contain sensitive data. Ensure your repository access controls are properly configured.
