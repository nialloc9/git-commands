# Gitflow

Shell functions and make targets for a standard Gitflow process with `develop`, `release`, and `hotfix` branches.

## Usage

### Option 1: Source in your shell profile

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
source "$HOME/projects/pensieve/git-commands/gitflow/git.sh"
```

Then use commands directly from any repo:

```bash
create_feature_branch "my-feature"
create_commit
```

### Option 2: Copy into your repo

Copy `git.sh` and `Makefile` into your project and use make targets:

```bash
make help
make feature NAME=my-feature
make commit
```

### Option 3: Claude Code skill

Use the `/git` slash command in Claude Code. See the [root README](../README.md#option-3-claude-code-skill) for setup instructions.

```
/git create a feature branch called my-feature
/git commit this as a fix
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

## Commands

### create_feature_branch

Creates `feature/<name>` from `DEVELOP_BRANCH`.

```bash
create_feature_branch "my-feature"
```

### create_hotfix_branch

Creates `hotfix/<name>` from `MAIN_BRANCH`.

```bash
create_hotfix_branch "1.4.1-critical-fix"
```

### create_release

Creates `release/YYYY-MM-DD-HH-MM-SS` from `DEVELOP_BRANCH`.

```bash
create_release
```

### sync_current_branch_with_default

Updates your current branch by merging the latest `DEVELOP_BRANCH`.

```bash
sync_current_branch_with_default
```

### create_commit

Prompts for a Conventional Commit type (`feat`, `fix`, `refactor`, `docs`, `chore`) and message, syncs with develop, commits, and pushes.

```bash
create_commit
```

### create_dev_release

Pushes the current branch and prints a GitHub PR URL.

```bash
create_dev_release
```

## Makefile Commands

```bash
make help
make feature NAME=my-feature
make release
make hotfix NAME=1.4.1-critical-fix
make sync
make commit
make dev-release
```

## Notes

- The PR URL is derived from `remote.origin.url` and supports both GitHub.com and GitHub Enterprise.
- `DEVELOP_BRANCH` and `MAIN_BRANCH` default to `develop` and `main` if not set.
