##
# terraform.tfvars
# This provides the list of Github reources.
##

repositories = {
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
  terraform_k8s_cluster = {
    name                 = "terraform-k8s-cluster"
    description          = "Terraform configuration for Kubernetes cluster setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "kubernetes", "infrastructure"]
    manage_files         = true
  }
  terraform_aws_vpc = {
    name                 = "terraform-aws-vpc"
    description          = "Terraform configuration for AWS VPC setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "aws", "vpc"]
    manage_files         = true
  }
  terraform_aws_lambda = {
    name                 = "terraform-aws-lambda"
    description          = "Terraform configuration for AWS Lambda setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "aws", "lambda"]
    manage_files         = true
  }
  terraform_aws_s3 = {
    name                 = "terraform-aws-s3"
    description          = "Terraform configuration for AWS S3 setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "aws", "s3", "buckets"]
    manage_files         = true
  }
  terraform_aws_sns = {
    name                 = "terraform-aws-sns"
    description          = "Terraform configuration for AWS SNS setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "aws", "sns"]
    manage_files         = true
  }
  terraform_aws_sqs = {
    name                 = "terraform-aws-sqs"
    description          = "Terraform configuration for AWS SQS setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "aws", "sqs"]
    manage_files         = true
  }
  terraform_aws_ec2 = {
    name                 = "terraform-aws-ec2"
    description          = "Terraform configuration for AWS EC2 setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "aws", "ec2"]
    manage_files         = true
  }
  terraform_aws_rds = {
    name                 = "terraform-aws-rds"
    description          = "Terraform configuration for AWS RDS setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
  }
  terraform_aws_iam = {
    name                 = "terraform-aws-iam"
    description          = "Terraform configuration for AWS IAM setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
    topics               = ["terraform", "aws", "iam"]
    manage_files         = true
  }
  terraform_aws_eks = {
    name                 = "terraform-aws-eks"
    description          = "Terraform configuration for AWS EKS setup"
    repository_auto_init = true
    branch_deletion      = true
    main_branch          = "main"
    additional_branches  = ["test", "docs"]
  }
}
