#!/bin/bash

set -e

BRANCH_FROM=${BRANCH_FROM:-gh-pages}
printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"
git config pull.rebase false
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git branch
git fetch --unshallow origin || git fetch origin
git checkout -b "${BRANCH_FROM}" || git checkout "${BRANCH_FROM}"
git pull origin gh-pages || true
git branch
