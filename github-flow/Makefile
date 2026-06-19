SHELL := /bin/bash

SCRIPT := ./git.sh

.PHONY: help start sync commit pr

help:
	@echo "GitHub Flow Make Targets"
	@echo "  make start NAME=my-change   # create branch from default branch"
	@echo "  make sync                   # merge latest default branch into current branch"
	@echo "  make commit                 # interactive commit and push"
	@echo "  make pr                     # push current branch and print PR URL"

start:
	@if [[ -z "$(NAME)" ]]; then echo "Error: NAME is required. Example: make start NAME=my-change"; exit 1; fi
	@source "$(SCRIPT)" && start_branch "$(NAME)"

sync:
	@source "$(SCRIPT)" && sync_current_branch_with_default

commit:
	@source "$(SCRIPT)" && commit_and_push_with_type

pr:
	@source "$(SCRIPT)" && push_branch_and_print_pr_url
