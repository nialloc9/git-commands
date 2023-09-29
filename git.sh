# Function to create a feature branch
function create_feature_branch() {
  create_branch "feature" $1
}

# Function to create a fixes branch
function create_fixes_branch() {
  create_branch "fixes" $1
}

# Function to create a refactor branch
function create_refactor_branch() {
  create_branch "refactor" $1
}

# Function to create a docs branch
function create_docs_branch() {
  create_branch "docs" $1
}

# Helper function to avoid code duplication
function create_branch() {
  prefix=$1
  name=$2

  # Argument validation
  if [ -z "$name" ]; then
    echo "Please provide a name for the branch."
    return 1
  fi

  # Checkout the dev branch
  git checkout dev

  # Create a new branch with the provided prefix and switch to it
  git checkout -b ${prefix}/${name}

  # Push the branch to the remote repository
  git push -u origin ${prefix}/${name}
}

function commit_push_merge_dev() {
  # Store the current branch name
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  # Commit all changes in the current branch
  git add . && git commit -m "Committing changes in $current_branch"

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
}
