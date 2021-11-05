terraform {
  required_version = "~> 1.0.4"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  owner = "LeeTann"
}

# Add a repository
resource "github_repository" "repository" {
  name        = "My-Awesome-Test-Repo"
  description = "This repository only exists for testing purposes."
  visibility  = "public"

  allow_merge_commit = true

  auto_init          = true
  gitignore_template = "Terraform"
  license_template   = "mit"
}

# Configure a branch protection for the repository
resource "github_branch_protection" "repository" {
  repository_id       = github_repository.repository.name
  pattern             = "main"
  enforce_admins      = true
  allows_deletions    = false
  allows_force_pushes = false

  required_status_checks {
    strict   = true
    contexts = []
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }
}
