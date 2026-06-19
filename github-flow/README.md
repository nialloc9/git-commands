# github-flow Folder

This folder contains GitHub Flow-specific automation scripts.

## Folder Contents

- `git.sh`: GitHub Flow shell functions (start branch, sync, commit, PR URL)
- `Makefile`: Make targets that wrap the shell functions in `git.sh`
- `README.md`: This documentation

## Quick Start From This Folder

```bash
cd github-flow
source ./git.sh
```

Or use make targets directly:

```bash
cd github-flow
make help
```

## Configuration

```bash
export DEFAULT_BRANCH="main"
```

Defaults:

- `DEFAULT_BRANCH=main`

PR links are generated from `remote.origin.url`, so both GitHub.com and GitHub Enterprise remotes are supported automatically.

## Standard GitHub Flow Commands

### start_branch

Creates `<branch-name>` from `DEFAULT_BRANCH`.

```bash
start_branch "my-change"
```

### sync_current_branch_with_default

Updates your current branch by merging the latest `DEFAULT_BRANCH`.

```bash
sync_current_branch_with_default
```

### commit_and_push_with_type

Prompts for a Conventional Commit type (`feat`, `fix`, `refactor`, `docs`, `chore`) and message, syncs with default, commits, and pushes.

```bash
commit_and_push_with_type
```

### push_branch_and_print_pr_url

Pushes the current branch and prints a PR URL.

```bash
push_branch_and_print_pr_url
```

## Makefile Commands

```bash
make help
make start NAME=my-change
make sync
make commit
make pr
```
