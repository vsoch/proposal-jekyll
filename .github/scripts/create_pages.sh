#!/bin/bash

set -e

BRANCH_FROM=${BRANCH_FROM:-gh-pages}
printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git branch
git checkout -b "${BRANCH_FROM}" || git checkout "${BRANCH_FROM}"
git branch
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"
# Move everything from docs into PWD (this should keep proposals I think)
cp -R docs/* .
git add .
if git diff-index --quiet HEAD --; then
    printf "No changes\n"
else
    printf "Changes\n"
    git commit -m "Automated deployment of pages! $(date '+%Y-%m-%d')"
    git push origin "${BRANCH_FROM}" --force
fi
