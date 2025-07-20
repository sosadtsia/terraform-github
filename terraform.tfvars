##
# terraform.tfvars
# This provides the list of Github reources.
##

repositories = {
  bike_parts_finder = {
    name                 = "bike-parts-finder"
    description          = "Bike parts finder"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["aws", "go", "eks"]
    manage_files         = true
  }
  shell_scripts = {
    name                 = "shell-scripts"
    description          = "Shell scripts for various tasks"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = []
    topics               = ["shell", "scripts"]
    manage_files         = true
  }
  terraform_aws_monitoring = {
    name                 = "terraform-aws-monitoring"
    description          = "Terraform configuration for AWS monitoring setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
  }
}

