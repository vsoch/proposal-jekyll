#!/bin/bash

set -e

# When we start, we've already cloned gh-pages in PWD
git clone https://github.com/${REPOSITORY} /tmp/repo

BRANCH_FROM=${BRANCH_FROM:-gh-pages}
printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"

# We haven't created the site yet
if  [[ ! -d "docs" ]]; then
    printf "You haven't created the site yet - use the creation workflow first.\n"
else
    # Update current content to what is in main
    for file in $(find /tmp/repo); do
        relpath=$(realpath --relative-to=/tmp/repo "$file")
        # Skip .git history
        if [[ $relpath = .git* ]] && [[ ! $relpath = .github* ]]; then
            continue
        fi 
        # If it's a directory, make relative path and continue
        if [[ -d "${file}" ]]; then
            mkdir -p ${relpath}
            continue
        fi
        dir=$(dirname $relpath)   
        if [[ "${dir}" != "." ]]; then
            mkdir -p ${dir}
        fi
        printf "cp $file $relpath\n"
        cp $file $relpath
        printf "git add $relpath\n"
        git add $relpath
    done
fi

git commit -m "Automated deployment of pages! $(date '+%Y-%m-%d')" || exit 0
git push origin "${BRANCH_FROM}" --force || exit 0
