variable "repositories" {
  type = map(object({

    # The name of the repository.
    name = string,

    # The description of the repository.
    description = string,

    # Whether or not to produce an initial commit in the repository.
    repository_auto_init = bool,

    # Whether or not to allow the branch to be deleted.
    branch_deletion = bool,

    # The name of the main branch for the repository.
    main_branch = string,

    # A list of additional branches for the repository.
    additional_branches = list(string)

    # A list of topics for the repository.
    topics = list(string)

    # Optional fields for branch protection
    allow_auto_merge                = optional(bool, false)
    required_status_checks          = optional(list(string), [])
    required_approving_review_count = optional(number, 1)
    dismissal_restrictions          = optional(list(string), [])
    pull_request_bypassers          = optional(list(string), [])

  }))
  description = "Setup the GitHub repositories."

  validation {
    condition = alltrue([
      for k, v in var.repositories : can(regex("^[a-zA-Z0-9._-]+$", v.name))
    ])
    error_message = "Repository names must only contain alphanumeric characters, periods, underscores, and hyphens."
  }

  validation {
    condition = alltrue([
      for k, v in var.repositories : contains(["main", "master", "develop"], v.main_branch)
    ])
    error_message = "Main branch must be one of: main, master, develop."
  }

  validation {
    condition = alltrue([
      for k, v in var.repositories : v.required_approving_review_count >= 1 && v.required_approving_review_count <= 6
    ])
    error_message = "Required approving review count must be between 1 and 6."
  }
}

variable "github_token" {
  type        = string
  description = "Authenticate to github"
  default     = ""
}
