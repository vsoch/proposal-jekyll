#!/bin/bash

set -e
if [[ "${proposals}" == "" ]]; then
    printf "No new proposals found\n"
    exit 0
fi

BRANCH_FROM=${BRANCH_FROM:-gh-pages}
printf "Proposals:\n${proposals}\n"

# Add new draft proposals!
mkdir -p docs/_proposals/drafts

for file in ${proposals}; do

    if [[ ! -f "${file}" ]]; then
        printf "Skipping ${file}, does not exist.\n"
        continue
    fi    
    name=$(basename ${file})
    dest=docs/_proposals/drafts/${name}
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
