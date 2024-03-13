function shtash()
{
    if [ "$1" = "apply" ]; then
        git merge stash/$2 --no-commit --no-ff
        git reset
    elif [ "$1" = "list" ]; then
        git branch -a | grep stash/ | sed 's/.*stash\///'
    elif [ "$1" = "save" ]; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        # check if branch exists
        if git rev-parse --verify stash/$2 >/dev/null 2>&1; then
            # prompt to delete
            read -p "Branch stash/$2 already exists. Replace? [y/N] " -n 1 -r
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                git branch -D stash/$2
            else
                return
            fi
        fi
        git checkout -b stash/$2
        git add .
        git commit -m "WIP"
        git checkout $branch
    elif [ "$1" = "replace" ]; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        # check if branch exists & delete it
        if git rev-parse --verify stash/$2 >/dev/null 2>&1; then
            git branch -D stash/$2
        fi
        git checkout -b stash/$2
        git add .
        git commit -m "WIP"
        git checkout $branch
    else
        echo "shtash is a better way to manage your git stashes
shtash allows you to name your stashes so you can have multiple stashes
independent from one another, accessible by the name you gave them.

Usage:
    shtash apply <name>    - Apply a stash to your current branch
    shtash list            - List all stashes
    shtash save <name>     - Save your current changes to a new stash
    shtash replace <name>  - Replace a stash with your current changes"
    fi
}
