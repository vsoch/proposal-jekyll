#!/bin/bash

set -e
if [[ "${changed_files}" == "" ]]; then
    printf "No changed proposals found\n"
    exit 0
fi

BRANCH_FROM=${BRANCH_FROM:-gh-pages}
printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git branch
git fetch --unshallow origin
git checkout -b "${BRANCH_FROM}" || git checkout "${BRANCH_FROM}"
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
    git push origin "${BRANCH_FROM}" --force
fi
