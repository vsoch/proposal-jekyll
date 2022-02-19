#!/bin/bash

# Check for a duplicate draft on PR open or reopen.

set -e
if [[ "${proposals}" == "" ]]; then
    printf "No new proposals found\n"
    exit 0
fi

for file in ${proposals}; do
    name=$(basename ${file})
    dest=_proposals/drafts/${name}

    if [[ -f "${dest}" ]]; then    
        printf "You cannot work on ${dest} at this time, the draft is already being worked on. Find the pull request in progress and contribute there."
    fi
done
