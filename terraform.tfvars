##
# terraform.tfvars
# This provides the list of Github reources.
##

repositories = {
  aws_cost_optimization = {
    name                 = "aws-cost-optimization"
    description          = "AWS cost optimization project"
    repository_auto_init = true
    branch_deletion      = false
    main_branch          = "main"
    additional_branches  = []
    topics               = ["aws"]
    manage_files         = true
  }

  bike_parts_finder = {
    name                 = "bike-parts-finder"
    description          = "Project that helps to find bike parts"
    repository_auto_init = true
    branch_deletion      = false
    main_branch          = "main"
    additional_branches  = ["develop", "production"]
    topics               = ["aws"]
    manage_files         = true
  }

  shell_scripts = {
    name                 = "scripts"
    description          = "Scripts for various tasks"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = []
    topics               = ["scripts"]
    manage_files         = true
  }

  network_scanner = {
    name                 = "network-scanner"
    description          = "Network scanner project"
    repository_auto_init = true
    branch_deletion      = false
    main_branch          = "main"
    additional_branches  = []
    topics               = ["golang", "network", "scanner"]
    manage_files         = true
  }

}

