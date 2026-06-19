DEVELOP_BRANCH=${DEVELOP_BRANCH:-develop}
MAIN_BRANCH=${MAIN_BRANCH:-main}

function ensure_git_repository() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a git repository."
    return 1
  fi
}

function get_project_name() {
  local repository_path
  repository_path=$(get_repository_path_from_origin_remote)
  basename "$repository_path"
}

function get_repository_path_from_origin_remote() {
  local remote_url repository_path

  remote_url=$(git config --get remote.origin.url)
  if [[ -z "$remote_url" ]]; then
    echo "Error: remote.origin.url is not configured."
    return 1
  fi

  repository_path=$(echo "$remote_url" | sed -E 's#^(git@|ssh://git@|https?://)([^/:]+)[:/]##; s#\.git$##')

  if [[ "$repository_path" == "$remote_url" || -z "$repository_path" ]]; then
    echo "Error: Unable to parse repository path from remote URL: $remote_url"
    return 1
  fi

  echo "$repository_path"
}

function get_github_host_from_origin_remote() {
  local remote_url github_host

  remote_url=$(git config --get remote.origin.url)
  if [[ -z "$remote_url" ]]; then
    echo "Error: remote.origin.url is not configured."
    return 1
  fi

  github_host=$(echo "$remote_url" | sed -E 's#^(git@|ssh://git@|https?://)([^/:]+).*#\2#')
  if [[ -z "$github_host" || "$github_host" == "$remote_url" ]]; then
    echo "Error: Unable to parse GitHub host from remote URL: $remote_url"
    return 1
  fi

  echo "$github_host"
}

function push_branch_and_print_pr_url() {
  local branch_name github_host repository_path
  branch_name=$(git branch --show-current)
  github_host=$(get_github_host_from_origin_remote) || return 1
  repository_path=$(get_repository_path_from_origin_remote) || return 1

  git push --set-upstream origin "$branch_name"
  echo "Create PR: https://$github_host/$repository_path/pull/new/$branch_name"
}

function checkout_and_update_branch() {
  local base_branch="$1"
  git checkout "$base_branch" || return 1
  git pull origin "$base_branch" || return 1
}

function prompt_for_branch_suffix() {
  local provided_suffix="$1"

  if [[ -n "$provided_suffix" ]]; then
    echo "$provided_suffix"
    return 0
  fi

  read -r -p "Enter branch name: " provided_suffix
  echo "$provided_suffix"
}

function create_gitflow_branch() {
  local branch_prefix="$1"
  local base_branch="$2"
  local suffix="$3"
  local full_branch_name

  ensure_git_repository || return 1

  suffix=$(prompt_for_branch_suffix "$suffix")
  if [[ -z "$suffix" ]]; then
    echo "Error: Branch name cannot be empty."
    return 1
  fi

  full_branch_name="$branch_prefix/$suffix"
  echo "Creating $full_branch_name from $base_branch"

  checkout_and_update_branch "$base_branch" || return 1
  git checkout -b "$full_branch_name" || return 1
  git push -u origin "$full_branch_name"
}

function start_feature_branch() {
  create_gitflow_branch "feature" "$DEVELOP_BRANCH" "$1"
}

function start_release_branch() {
  create_gitflow_branch "release" "$DEVELOP_BRANCH" "$1"
}

function start_hotfix_branch() {
  create_gitflow_branch "hotfix" "$MAIN_BRANCH" "$1"
}

function sync_current_branch_with_develop() {
  local current_branch

  ensure_git_repository || return 1
  current_branch=$(git branch --show-current)

  checkout_and_update_branch "$DEVELOP_BRANCH" || return 1
  git checkout "$current_branch" || return 1
  git merge "$DEVELOP_BRANCH"

  echo "Updated $current_branch with latest changes from $DEVELOP_BRANCH"
}

function commit_and_push_with_type() {
  local commit_type commit_message

  ensure_git_repository || return 1

  read -r -p "Enter commit type (feat, fix, refactor, docs, chore, none): " commit_type
  if [[ "$commit_type" == "none" ]]; then
    return 0
  fi

  if [[ "$commit_type" != "feat" && "$commit_type" != "fix" && "$commit_type" != "refactor" && "$commit_type" != "docs" && "$commit_type" != "chore" ]]; then
    echo "Invalid type. Please use one of 'feat', 'fix', 'refactor', 'docs', 'chore'."
    return 1
  fi

  sync_current_branch_with_develop || return 1

  read -r -p "Enter commit message: " commit_message

  git add .
  git commit -m "${commit_type}: ${commit_message}"
  git push
}

function release_current_branch() {
  ensure_git_repository || return 1
  push_branch_and_print_pr_url
}

# Backward-compatible wrappers (legacy names)
function create_feature_branch() {
  start_feature_branch "$1"
}

function create_fixes_branch() {
  echo "Deprecated: use start_hotfix_branch instead."
  start_hotfix_branch "$1"
}

function update_from_dev() {
  sync_current_branch_with_develop
}

function git_commit() {
  commit_and_push_with_type
}

function release() {
  start_release_branch "$1"
}

function release_dev() {
  release_current_branch
}