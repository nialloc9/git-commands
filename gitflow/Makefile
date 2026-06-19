SHELL := /bin/bash

SCRIPT := ./git.sh

.PHONY: help feature release-branch hotfix sync commit pr

help:
	@echo "Gitflow Make Targets"
	@echo "  make feature NAME=my-feature        # create feature/<name> from develop"
	@echo "  make release-branch NAME=1.4.0      # create release/<name> from develop"
	@echo "  make hotfix NAME=1.4.1-critical-fix # create hotfix/<name> from main"
	@echo "  make sync                           # merge latest develop into current branch"
	@echo "  make commit                         # interactive commit and push"
	@echo "  make pr                             # push current branch and print PR URL"

feature:
	@if [[ -z "$(NAME)" ]]; then echo "Error: NAME is required. Example: make feature NAME=my-feature"; exit 1; fi
	@source "$(SCRIPT)" && start_feature_branch "$(NAME)"

release-branch:
	@if [[ -z "$(NAME)" ]]; then echo "Error: NAME is required. Example: make release-branch NAME=1.4.0"; exit 1; fi
	@source "$(SCRIPT)" && start_release_branch "$(NAME)"

hotfix:
	@if [[ -z "$(NAME)" ]]; then echo "Error: NAME is required. Example: make hotfix NAME=1.4.1-critical-fix"; exit 1; fi
	@source "$(SCRIPT)" && start_hotfix_branch "$(NAME)"

sync:
	@source "$(SCRIPT)" && sync_current_branch_with_develop

commit:
	@source "$(SCRIPT)" && commit_and_push_with_type

pr:
	@source "$(SCRIPT)" && release_current_branch
