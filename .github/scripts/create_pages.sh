#!/bin/bash

set -e

BRANCH_FROM=${BRANCH_FROM:-gh-pages}
printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git branch
git fetch --unshallow origin
git checkout -b "${BRANCH_FROM}" || git checkout "${BRANCH_FROM}"
git branch
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"

# We haven't created the site yet
if  [[ ! -d "docs" ]]; then
    git add .
    git commit -m "Automated deployment of pages! $(date '+%Y-%m-%d')" || exit 0
    git push origin "${BRANCH_FROM}" --force || exit 0
else
    printf "This site has already been created. Use the update workflow instead.\n"
fi
