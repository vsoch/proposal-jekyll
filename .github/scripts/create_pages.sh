#!/bin/bash

set -e

# Copy current site
cp -R . /tmp/repo

printf "Before checkout:\n"
ls

printf "Copied over:\n"
ls /tmp/repo

BRANCH_FROM=${BRANCH_FROM:-gh-pages}
printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git branch
git checkout -b "${BRANCH_FROM}" || git checkout "${BRANCH_FROM}"
git branch
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"

printf "After checkout:\n"
ls

# We haven't created the site yet
if  [[ ! -d "docs" ]]; then
    mv /tmp/repo/docs docs/
    mv /tmp/repo/proposals proposals/
    mv /tmp/repo/README.md README.md
else
    # Update current content to what is in main
    for file in $(find /tmp/repo); do
        printf "Found file: ${file}\n"
        relpath=$(realpath --relative-to=/tmp/repo "$file")
        printf "Realpath: ${relpath}\n"
        dir=$(dirname $relpath)   
        printf "Directory: ${dir}\n"
        if [[ "${dir}" != "." ]]; then
            mkdir -p ${dir}
        fi
        printf "cp $file $relpath\n"
        cp $file $relpath
        printf "git add $relpath\n"
        git add $relpath
    done
fi

if git diff-index --quiet HEAD --; then
    printf "No changes\n"
else
    printf "Changes\n"
    git commit -m "Automated deployment of pages! $(date '+%Y-%m-%d')"
    git push origin "${BRANCH_FROM}" --force
fi
