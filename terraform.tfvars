##
# terraform.tfvars
# This provides the list of Github reources.
##

repositories = {
  terraform_k8s_cluster = {
    name                 = "terraform-k8s-cluster"
    description          = "Terraform configuration for Kubernetes cluster setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "kubernetes", "infrastructure"]
  }
  shell_scripts = {
    name                 = "shell-scripts"
    description          = "Shell scripts for various tasks"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = []
    topics               = ["shell", "scripts"]
  }
}
