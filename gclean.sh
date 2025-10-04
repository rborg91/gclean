#!/bin/bash
set -e

# Set default test value to false
test=false

# Parse flags
while [[ $# -gt 0 ]]; do
	case "$1" in
	--test)
		# Change test value to true if --test flag used
		test=true
		;;
	--help)
		echo "Usage: $0 [--test] [--help]"
		echo "  --test  Enable test mode"
		echo "  --help  Show this message and exit"
		exit 0
		;;
	*)
		echo "Unknown option: $1"
		echo "Try '$0 --help' for more information."
		exit 1
		;;
	esac
	shift
done

# Echo what mode this is running in
if $test; then
	echo -e "TEST MODE\n"
else
	echo -e "LIVE MODE\n"
fi

# Switch to main or master if present
if git show-ref --verify --quiet refs/heads/main; then
	git switch main
elif git show-ref --verify --quiet refs/heads/master; then
	git switch master
else
	echo "No 'main' or 'master' branch found."
	exit 1
fi

# Pull latest changes
git pull

# Update remote-tracking branches to remove branches that no longer exist remotely
git fetch --prune

# Show all branches
echo "=== Branches ==="
git branch -a

# Find and delete (or simulate deletion of) local branches that don’t exist remotely
# set deleted_branches to false as default to detect whether any branches are deleted or not
deleted_branches=false
for branch in $(git branch --format="%(refname:short)" | grep -vE "^(main|master)$"); do
	if ! git show-ref --verify --quiet refs/remotes/origin/"$branch"; then
		# Set deleted_branches value to true to skip echoing "No local branches to be deleted"
		deleted_branches=true
		if $test; then
			echo "[TEST] Would delete local branch: $branch"
		else
			echo "Deleting local branch: $branch"
			git branch -d "$branch"
		fi
	fi
done

# Show message if no branches are to be deleted/were not deleted
if ! $deleted_branches; then
	echo "No local branches to be deleted"
fi
