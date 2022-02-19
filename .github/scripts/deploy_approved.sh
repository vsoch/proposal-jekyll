#!/bin/bash

set -e
if [[ "${proposals}" == "" ]] && [[ "${removed}" == "" ]]; then
    printf "No new or removed proposals found\n"
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

# Removed proposals
for file in ${removed}; do

    name=$(basename ${file})
    dest=_proposals/${name}

    # If the proposal exists, remove from site
    if [[ -f ${dest} ]]; then
        printf "Proposal draft ${file} is removed, deleting ${dest}\n"
        rm ${dest}
    fi
done

# Add new proposals!
mkdir -p _proposals
for file in ${proposals}; do
    name=$(basename ${file})
    dest=_proposals/${name}
    printf "Copying ${file} -> ${dest}\n"
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
