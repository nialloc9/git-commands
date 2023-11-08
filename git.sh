# Function to create a feature branch
function create_feature_branch() {
  create_branch "feature"
}

# Function to create a fixes branch
function create_fixes_branch() {
  create_branch "fixes"
}

# Function to create a refactor branch
function create_refactor_branch() {
  create_branch "refactor"
}

# Function to create a docs branch
function create_docs_branch() {
  create_branch "docs"
}

# Helper function to create a branch
function create_branch() {

  # Check if the type is one of the allowed types
  if [[ "$1" != "feature" && "$1" != "fixes" && "$1" != "refactor" && "$1" != "docs" ]]; then
    echo "Invalid type. Please use one of 'feature', 'fixes', 'refactor', 'docs'."
    return 1
  fi

  # Prompt the user for branch name
  echo "Enter branch name:"
  read name

  echo "Creating $1/$name branch"
  # Checkout the dev branch
  git checkout dev

  # Create a new branch with the provided prefix and switch to it
  git checkout -b "$1/$name"

  # Push the branch to the remote repository
  git push -u origin "$1/$name"
}

function commit_push_merge_dev() {
  # Store the current branch name
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  # Commit all changes in the current branch
  git_commit

  # Push the current branch to remote
  git push origin $current_branch

  # Checkout the dev branch
  git checkout dev

  # Merge changes from the current branch into dev
  git merge $current_branch

  # Push merged changes in dev to remote
  git push origin dev
}

function merge_dev_into_main() {
  # Ensure you're in a git repository
  if [ ! -d .git ]; then
    echo "Error: Not in a git repository."
    return 1
  fi

  # Checkout the dev branch
  git checkout dev

  # Pull the latest changes from the remote's dev branch
  git pull origin dev

  # Checkout the main branch
  git checkout main

  # Merge the latest changes from dev into main
  git merge dev

  git push origin main
}

function git_commit() {
    # Prompt the user for commit type
    echo "Enter commit type (feat, fixes, refactor):"
    read type

    # Check if the type is one of the allowed types
    if [[ "$type" != "feat" && "$type" != "fixes" && "$type" != "refactor" ]] then
        echo "Invalid type. Please use one of 'feat', 'fixes', 'refactor'."
        return 1
    fi

    # Prompt the user for commit message
    echo "Enter commit message:"
    read message

    # Commit everything to git with the provided message
    git add .
    git commit -m "${type}:${message}"
    git push
}

function release() {
  echo "Release to: (main, dev)"
  read type

  # Store the current branch name
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  # Commit all changes in the current branch
  git add .
  git commit -m "release: release $current_branch to $type"
  git push

  # Push the current branch to remote
  git push origin $current_branch

  # Checkout the dev branch
  git checkout $type

  # Merge changes from the current branch into dev
  git merge $current_branch

  # Push merged changes in dev to remote
  git push origin $type
}