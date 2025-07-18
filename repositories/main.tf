/**
 * main.tf
 * Main entrypoint for the module.
 */

terraform {
  required_version = ">= 1.10.3"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13.0"
    }
  }
}
