/**
 * variables.tf
 * Defines variables (inputs) that this module takes.
 */

# Repository specific.
variable "name" {
  type        = string
  description = "The name of the Github repository to be created."
}

variable "description" {
  type        = string
  description = "The description of the github repository."
}

variable "main_branch" {
  type        = string
  description = "The main branch of the repository, typically `develop` if there are more than one branches, and `main` if not."
}

variable "additional_branches" {
  type        = list(string)
  description = "A list of additional branches for the repository."
}

variable "branch_deletion" {
  type        = bool
  default     = false
  description = "Whether or not allow the branch to be deleted."
}

variable "delete_branch_on_merge" {
  type        = bool
  default     = true
  description = "Whether or not to delete the branch after a merge."
}

variable "dismissal_restrictions" {
  type        = list(string)
  description = "A list of teams node ID with dismissal access."
}

variable "pull_request_bypassers" {
  type        = list(string)
  description = "A list of teams node ID that are allowed to bypass pull request requirements."
}

variable "repository_auto_init" {
  type        = bool
  default     = false
  description = "Whether or not to produce an initial commit in the repository."
}

variable "topics" {
  type        = list(string)
  default     = []
  description = "A list of topics to create for the GitHub repository"
}

variable "allow_auto_merge" {
  type        = bool
  default     = false
  description = "Whether to allow auto-merge on pull requests."
}

variable "required_status_checks" {
  type        = list(string)
  default     = []
  description = "List of status checks that must pass before merging."
}

variable "required_approving_review_count" {
  type        = number
  default     = 1
  description = "Number of required approving reviews."
}

variable "manage_files" {
  type        = bool
  default     = true
  description = "Whether to manage repository files (renovate config, workflows, etc.)"
}
