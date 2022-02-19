#!/bin/bash

set -e
if [[ "${proposals}" == "" ]]; then
    printf "No new proposals found\n"
    exit 0
fi

BRANCH_FROM=${BRANCH_FROM:-gh-pages}
printf "GitHub Actor: ${GITHUB_ACTOR}\n"
git remote set-url origin "https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git branch
git checkout -b "${BRANCH_FROM}" || git checkout "${BRANCH_FROM}"
git branch
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"

# Add new proposals!
mkdir -p _proposals
for file in ${propoals}; do
    name=$(basename ${file})
    dest=_proposals/${name}
    printf "Copying ${file} -> ${dest}"
    cp ${file} ${dest}
    git add ${dest}
done
if git diff-index --quiet HEAD --; then
    printf "No changes\n"
else
    printf "Changes\n"
    git commit -m "Automated deployment of new proposals! $(date '+%Y-%m-%d')"
    git push origin "${BRANCH_FROM}" --force
fi
