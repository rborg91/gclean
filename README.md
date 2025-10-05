# gclean
Bash script that git pulls a repository and cleans up local branches that no longer exist remotely.

## How it works
- Switches to main/master branch
- Git pulls latest changes
- Runs `git fetch --prune` which fetches updates from the remote and cleans up local references to deleted remote branches.
- Echos branches so the user can see current local and remote branches
- If in test mode, it shows you what branches exist locally but not remotely and simulates
a removal of the branch
- If in live mode, it deletes any branches that exist locally but not remotely.

## Prerequisites
- bash - check by running `bash --version`
- git - check by running `git --version`

## Installation
- Clone this repository to your local machine.
- It is recommended that you add this script to your PATH so that you can access this script from anywhere on your local machine. To do this, create a symbolic link by following these instructions (NOTE that symbolic links should use absolute paths):
- To have this script added to just your user's path, run:
`ln -s path/to/gclean.sh $HOME/.local/bin/gclean`
- To have this script added to all users' paths, run:
`sudo ln -s path/to/gclean.sh /usr/local/bin/gclean`
- Then all you have to do is run `gclean` using the **Usage** instructions below.
- But you may have a better name for this script. If so, follow the symbolic link instructions,
but ensure that the name of the symbolic link is your better named script.
e.g. `ln -s path/to/gclean.sh $HOME/.local/bin/better-name`

## Usage
- `cd` into the repository that you want to clean up local branches for.
- To clean up the branches, run `gclean`.
- If you want to see what branches are going to be deleted before you actually remove these
branches, run the script in test mode: `gclean --test`.
- If there are any branches that exist
locally but not remotely and you want them to remain (e.g. you are working on the branch
and haven't pushed it yet), it is best not to run the script and instead clean it up manually.
