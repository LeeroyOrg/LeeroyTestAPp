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
  owner = "LeeroyOrg"
  token = var.GITHUB_TOKEN
}

# Add a repository
resource "github_repository" "repo1" {
  name        = "My-Awesome-Test-Repo-1"
  description = "This repository only exists for testing purposes."
  visibility  = "public"

  allow_merge_commit = true

  auto_init          = true
  gitignore_template = "Terraform"
  license_template   = "mit"
}

resource "github_repository" "repo2" {
  name        = "My-Awesome-Test-Repo-2"
  description = "This repository only exists for testing purposes."
  visibility  = "public"

  allow_merge_commit = true

  auto_init          = true
  gitignore_template = "Terraform"
  license_template   = "mit"
}

resource "github_repository" "repo3" {
  name        = "Manual-Test-Repo"
  description = "This repository was created manually and now trying to bring under terraform managed repo."
  visibility  = "public"

  allow_merge_commit = true

  auto_init          = true
  gitignore_template = "Terraform"
  license_template   = "mit"
  is_template        = true
}

# Configure a branch protection for the repository
resource "github_branch_protection" "rule1" {
  repository_id       = github_repository.repo1.name
  pattern             = "main"
  enforce_admins      = true
  allows_deletions    = false
  allows_force_pushes = false

  required_status_checks {
    strict   = true
    contexts = []
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    require_code_owner_reviews      = true
    required_approving_review_count = 2
  }
}

# Configure a branch protection for the repository
resource "github_branch_protection" "rule2" {
  repository_id       = github_repository.repo2.name
  pattern             = "main"
  enforce_admins      = true
  allows_deletions    = false
  allows_force_pushes = false

  required_status_checks {
    strict   = true
    contexts = []
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }
}
