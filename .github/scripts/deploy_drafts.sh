#!/bin/bash

set -e
if [[ "${proposals}" == "" ]]; then
    printf "No new proposals found\n"
    exit 0
fi

# Add new draft proposals!
mkdir -p _proposals/drafts

for file in ${proposals}; do
    name=$(basename ${file})
    dest=_proposals/drafts/${name}
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
