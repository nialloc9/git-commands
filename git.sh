GIT_ACCOUNT_IDENTIFIER=nialloc9

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

  git pull origin dev
  
  # Create a new branch with the provided prefix and switch to it
  git checkout -b "$1/$name"

  # Push the branch to the remote repository
  git push -u origin "$1/$name"
}

# Function to update current branch with latest dev changes
function update_from_dev() {
    # Store the current branch name
    CURRENT_BRANCH=$(git branch --show-current)
    
    # Checkout dev and pull latest changes
    git checkout dev
    git pull origin dev
    
    # Return to original branch and merge dev
    git checkout "$CURRENT_BRANCH"
    git merge dev
    
    echo "Updated $CURRENT_BRANCH with latest changes from dev"
}

function git_commit() {

    # Prompt the user for commit type
    echo "Enter commit type (feat, fixes, refactor, none):"
    read type

    if [[ "$type" = "none" ]] then
        return 0
    fi

    update_from_dev

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
    # Ensure we are in a git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Error: Not inside a git repository."
        return 1
    fi

    # Checkout dev branch
    git checkout dev && git pull origin dev

    # Get current date-time in DD-MM-YYYY-HH:MM format
    TIMESTAMP=$(date +"%d-%m-%Y-%H-%M")

    # Create new branch with the release timestamp
    RELEASE_BRANCH="release/$TIMESTAMP"
    git checkout -b "$RELEASE_BRANCH"

    echo "Switched to new release branch: $RELEASE_BRANCH"

    git push --set-upstream origin $RELEASE_BRANCH

    PROJECT_NAME=$(basename -s .git `git config --get remote.origin.url`)

    echo "Create PR: https://github.com/$GIT_ACCOUNT_IDENTIFIER/$PROJECT_NAME/pull/new/$RELEASE_BRANCH"
}

function release_dev() {
    # Ensure we are in a git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Error: Not inside a git repository."
        return 1
    fi

    git_commit

    RELEASE_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    PROJECT_NAME=$(basename -s .git `git config --get remote.origin.url`)

    git push --set-upstream origin $RELEASE_BRANCH

    echo "Create PR: https://github.com/$GIT_ACCOUNT_IDENTIFIER/$PROJECT_NAME/pull/new/$RELEASE_BRANCH"
}