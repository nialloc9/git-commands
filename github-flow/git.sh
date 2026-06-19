DEFAULT_BRANCH=${DEFAULT_BRANCH:-main}

function ensure_git_repository() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a git repository."
    return 1
  fi
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

function checkout_and_update_default_branch() {
  git checkout "$DEFAULT_BRANCH" || return 1
  git pull origin "$DEFAULT_BRANCH" || return 1
}

function prompt_for_branch_name() {
  local provided_branch_name="$1"

  if [[ -n "$provided_branch_name" ]]; then
    echo "$provided_branch_name"
    return 0
  fi

  read -r -p "Enter branch name: " provided_branch_name
  echo "$provided_branch_name"
}

function start_branch() {
  local branch_name="$1"

  ensure_git_repository || return 1
  branch_name=$(prompt_for_branch_name "$branch_name")

  if [[ -z "$branch_name" ]]; then
    echo "Error: Branch name cannot be empty."
    return 1
  fi

  checkout_and_update_default_branch || return 1
  git checkout -b "$branch_name" || return 1
  git push -u origin "$branch_name"
}

function sync_current_branch_with_default() {
  local current_branch

  ensure_git_repository || return 1
  current_branch=$(git branch --show-current)

  checkout_and_update_default_branch || return 1
  git checkout "$current_branch" || return 1
  git merge "$DEFAULT_BRANCH"

  echo "Updated $current_branch with latest changes from $DEFAULT_BRANCH"
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

  sync_current_branch_with_default || return 1

  read -r -p "Enter commit message: " commit_message

  git add .
  git commit -m "${commit_type}: ${commit_message}"
  git push
}

function push_branch_and_print_pr_url() {
  local branch_name github_host repository_path

  ensure_git_repository || return 1
  branch_name=$(git branch --show-current)
  github_host=$(get_github_host_from_origin_remote) || return 1
  repository_path=$(get_repository_path_from_origin_remote) || return 1

  git push --set-upstream origin "$branch_name"
  echo "Create PR: https://$github_host/$repository_path/pull/new/$branch_name"
}

# Backward-compatible aliases
function create_feature_branch() {
  start_branch "$1"
}

function update_from_main() {
  sync_current_branch_with_default
}

function release_dev() {
  push_branch_and_print_pr_url
}
