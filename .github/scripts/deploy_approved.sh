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
git fetch --unshallow origin || git fetch origin
git checkout -b "${BRANCH_FROM}" || git checkout "${BRANCH_FROM}"
git branch
git config --global user.name "github-actions"
git config --global user.email "github-actions@users.noreply.github.com"

# Deleted proposals - on merge a deleted file is removed from drafts and approved
for file in ${removed}; do

    name=$(basename ${file})
    draft=docs/_proposals/drafts/${name}
    approved=docs/_proposals/approved/${name}

    # If the proposal exists, remove from site
    for dest in ${draft} ${approved}; do
        if [[ -f ${dest} ]]; then
            printf "Proposal draft ${file} is removed, deleting ${dest}\n"
            rm ${dest}
        fi
    done
done

# Add new proposals to approved!
mkdir -p docs/_proposals/approved
for file in ${proposals}; do
    if [[ ! -f "${file}" ]]; then
        printf "Skipping ${file}, does not exist.\n"
        continue
    fi    
    name=$(basename ${file})
    dest=docs/_proposals/approved/${name}
    draft=docs/_proposals/drafts/${name}
    printf "Copying ${file} -> ${dest}\n"
    cp ${file} ${dest}
    git add ${dest}
    if [[ -f "${draft}" ]]; then
        printf "Removing previous draft ${draft}\n"
        rm ${draft}
    fi    
done
if git diff-index --quiet HEAD --; then
    printf "No changes\n"
else
    printf "Changes\n"
    git commit -m "Automated deployment of new proposals! $(date '+%Y-%m-%d')"
    git push origin "${BRANCH_FROM}" --force
fi
