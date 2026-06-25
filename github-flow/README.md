# GitHub Flow

Shell functions and make targets for a lightweight GitHub Flow process.

## Usage

### Option 1: Source in your shell profile

Add to your `~/.zshrc` or `~/.bashrc`:

```bash
source "$HOME/projects/pensieve/git-commands/github-flow/git.sh"
```

Then use commands directly from any repo:

```bash
create_feature_branch "my-change"
create_commit
```

### Option 2: Copy into your repo

Copy `git.sh` and `Makefile` into your project and use make targets:

```bash
make help
make feature NAME=my-change
make commit
```

### Option 3: Claude Code skill

Use the `/git` slash command in Claude Code. See the [root README](../README.md#option-3-claude-code-skill) for setup instructions.

```
/git create a feature branch called my-change
/git commit this as a fix
```

## Configuration

```bash
export DEFAULT_BRANCH="main"
```

Defaults:

- `DEFAULT_BRANCH=main`

PR links are generated from `remote.origin.url`, so both GitHub.com and GitHub Enterprise remotes are supported automatically.

## Commands

### create_feature_branch

Creates `<branch-name>` from `DEFAULT_BRANCH`.

```bash
create_feature_branch "my-change"
```

### create_release

Creates `release/YYYY-MM-DD-HH-MM-SS` from `DEFAULT_BRANCH`.

```bash
create_release
```

### sync_current_branch_with_default

Updates your current branch by merging the latest `DEFAULT_BRANCH`.

```bash
sync_current_branch_with_default
```

### create_commit

Prompts for a Conventional Commit type (`feat`, `fix`, `refactor`, `docs`, `chore`) and message, syncs with default, commits, and pushes.

```bash
create_commit
```

### push_branch_and_print_pr_url

Pushes the current branch and prints a PR URL.

```bash
push_branch_and_print_pr_url
```

## Makefile Commands

```bash
make help
make feature NAME=my-change
make release
make sync
make commit
make pr
```
