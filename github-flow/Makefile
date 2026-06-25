SHELL := /bin/bash

SCRIPT := ./git.sh

.PHONY: help feature release sync commit pr

help:
	@echo "GitHub Flow Make Targets"
	@echo "  make feature NAME=my-change  # create branch from default branch"
	@echo "  make release                 # create release/YYYY-MM-DD-HH-MM-SS from default branch"
	@echo "  make sync                    # merge latest default branch into current branch"
	@echo "  make commit                  # interactive commit and push"
	@echo "  make pr                      # push current branch and print PR URL"

feature:
	@if [[ -z "$(NAME)" ]]; then echo "Error: NAME is required. Example: make feature NAME=my-change"; exit 1; fi
	@source "$(SCRIPT)" && create_feature_branch "$(NAME)"

release:
	@source "$(SCRIPT)" && create_release

sync:
	@source "$(SCRIPT)" && sync_current_branch_with_default

commit:
	@source "$(SCRIPT)" && create_commit

pr:
	@source "$(SCRIPT)" && push_branch_and_print_pr_url
