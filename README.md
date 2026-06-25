<p align="center">
  <img src="logo.svg" alt="git commands" width="400">
</p>

<p align="center">Opinionated Git workflow helpers grouped by workflow style.</p>

## Workflows

- [gitflow](gitflow/README.md): Feature/release/hotfix branches with a `develop` branch.
- [github-flow](github-flow/README.md): Lightweight single-branch flow off `main`.

## Usage

There are two ways to use these scripts:

### Option 1: Source in your shell profile

Add one of the following to your `~/.zshrc` or `~/.bashrc`:

```bash
# For GitHub Flow
source "$HOME/projects/pensieve/git-commands/github-flow/git.sh"

# For Gitflow
source "$HOME/projects/pensieve/git-commands/gitflow/git.sh"
```

This makes all commands available as shell functions (e.g. `create_feature_branch`, `create_commit`).

### Option 2: Copy the Makefile and script into your repo

Copy the `Makefile` and `git.sh` from the workflow folder into your project:

```bash
# For GitHub Flow
cp github-flow/Makefile github-flow/git.sh /path/to/your/repo/

# For Gitflow
cp gitflow/Makefile gitflow/git.sh /path/to/your/repo/
```

Then use make targets from within your repo:

```bash
make help
make feature NAME=my-change
make commit
```

### Option 3: Claude Code skill

A `/git` slash command is available for Claude Code. It auto-detects whether the repo uses gitflow or github-flow and runs the right commands.

To install, copy the skill into your user-level Claude commands:

```bash
mkdir -p ~/.claude/commands
cp .claude/commands/git.md ~/.claude/commands/git.md
```

Then from any repo in Claude Code:

```
/git create a feature branch called my-feature
/git sync my branch
/git commit this as a fix
/git create a release
/git push and get a PR url
```

Claude will detect the workflow, ask for any missing details, and run the command.
