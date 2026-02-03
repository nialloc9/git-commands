# Git Helper Functions

A collection of shell functions designed to streamline various Git tasks, from branch creation to merging.

### Instructions to Add Functions to Zsh Profile

0. Change GIT_ACCOUNT_IDENTIFIER to your account

1. Open your Zsh configuration file:

```bash
nano ~/.zshrc
```

2. Scroll to the end of the file, and paste the provided bash functions.

3. Save and exit (for `nano`, press `CTRL + O` to save and `CTRL + X` to exit).

4. Reload your Zsh configuration:

```bash
source ~/.zshrc
```

Now, you should have access to the functions directly from your terminal.

### Environment Variables

Set `DEV_BRANCH` to customize the development branch (defaults to 'dev'):

```bash
export DEV_BRANCH="develop"
```

### create_feature_branch()

Create a new feature branch based on the 'dev' branch.

**Usage:**

```bash
create_feature_branch "new-feature-name"
```

### create_fixes_branch()

Create a new fixes branch based on the 'dev' branch.

**Usage:**

```bash
create_fixes_branch "bug-fix-name"
```

### create_refactor_branch()

Create a new refactor branch based on the 'dev' branch.

**Usage:**

```bash
create_refactor_branch "refactor-name"
```

### create_docs_branch()

Create a new documentation branch based on the 'dev' branch.

**Usage:**

```bash
create_docs_branch "documentation-update-name"
```

### create_poc_branch()

Create a new poc branch based on the 'dev' branch.

**Usage:**

```bash
create_poc_branch "integrate-fivetran"
```

### commit_push_merge_dev()

Commit, push, and create link to create PR.

**Usage:**

```bash
commit_push_merge_dev
```

### release_dev()

Commit, push, and create link to create PR.

**Usage:**

```bash
release_dev
```

### release()

Release current branch into an env.

**Usage:**

```bash
release
```

## Table of Contents

- [1. create_feature_branch()](#create_feature_branch)
- [2. create_fixes_branch()](#create_fixes_branch)
- [3. create_refactor_branch()](#create_refactor_branch)
- [4. create_docs_branch()](#create_docs_branch)
- [5. commit_push_merge_dev()](#commit_push_merge_dev)
- [6. release_dev()](#release_dev)
- [7. release()](#release)
