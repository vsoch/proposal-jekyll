#!/bin/bash

set -e

BRANCH_FROM=${BRANCH_FROM:-main}
printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git branch
git fetch --unshallow origin

changed_files=""
for file in $(git diff --diff-filter=A --name-only ${BRANCH_FROM}); do
    changed_files="$changed_files $file"
done

# For this PR we are cleaning up main
git checkout "${BRANCH_FROM}"
git branch
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"

# Removed proposals
for file in ${changed_files}; do

    name=$(basename ${file})

    # Only delete the draft if it was added
    dest=docs/_proposals/drafts/${name}
    # If the proposal exists, remove from site
    if [[ -f ${dest} ]]; then
        printf "Proposal draft ${file} is removed, deleting ${dest}\n"
        rm ${dest}
    fi
done

if git diff-index --quiet HEAD --; then
    printf "No changes\n"
else
    printf "Changes\n"
    git commit -m "Automated deployment of new proposals! $(date '+%Y-%m-%d')"
    git push origin "${BRANCH_FROM}"
fi
