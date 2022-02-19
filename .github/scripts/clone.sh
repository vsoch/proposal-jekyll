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
