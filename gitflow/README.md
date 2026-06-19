# gitflow Folder

This folder contains Gitflow-specific automation scripts.

## Folder Contents

- `git.sh`: Gitflow shell functions (feature/release/hotfix, sync, commit, PR URL)
- `Makefile`: Make targets that wrap the shell functions in `git.sh`
- `README.md`: This documentation

## Quick Start From This Folder

Run commands from this directory:

```bash
cd gitflow
source ./git.sh
```

Or use make targets directly:

```bash
cd gitflow
make help
```

## Configuration

```bash
export DEVELOP_BRANCH="develop"
export MAIN_BRANCH="main"
```

PR links are generated from `remote.origin.url`, so both GitHub.com and GitHub Enterprise remotes are supported automatically.

Supported remote URL formats include:

```bash
git@github.com:owner/repo.git
git@github.your-company.com:owner/repo.git
https://github.com/owner/repo.git
https://github.your-company.com/owner/repo.git
```

Defaults:

- `DEVELOP_BRANCH=develop`
- `MAIN_BRANCH=main`

## Standard Gitflow Commands

### start_feature_branch

Creates `feature/<name>` from `DEVELOP_BRANCH`.

```bash
start_feature_branch "my-feature"
```

### start_release_branch

Creates `release/<name>` from `DEVELOP_BRANCH`.

```bash
start_release_branch "1.4.0"
```

### start_hotfix_branch

Creates `hotfix/<name>` from `MAIN_BRANCH`.

```bash
start_hotfix_branch "1.4.1-critical-fix"
```

### sync_current_branch_with_develop

Updates your current branch by merging the latest `DEVELOP_BRANCH`.

```bash
sync_current_branch_with_develop
```

### commit_and_push_with_type

Prompts for a Conventional Commit type (`feat`, `fix`, `refactor`, `docs`, `chore`) and message, syncs with develop, commits, and pushes.

```bash
commit_and_push_with_type
```

### release_current_branch

Pushes the current branch and prints a GitHub PR URL.

```bash
release_current_branch
```

## Makefile Commands

You can run the same workflow with `make`:

```bash
make help
make feature NAME=my-feature
make release-branch NAME=1.4.0
make hotfix NAME=1.4.1-critical-fix
make sync
make commit
make pr
```

## Notes

- The PR URL is derived from `remote.origin.url` and supports both GitHub.com and GitHub Enterprise.
- `DEVELOP_BRANCH` and `MAIN_BRANCH` default to `develop` and `main` if not set.

## Backward Compatibility

Legacy names are still available as wrappers:

- `create_feature_branch`
- `create_fixes_branch` (deprecated, now maps to hotfix)
- `update_from_dev`
- `git_commit`
- `release`
- `release_dev`
