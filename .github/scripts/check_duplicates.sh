#!/bin/bash

# Check for a duplicate draft on PR open or reopen.

set -e

for file in $(git diff --diff-filter=A --name-only main); do
    name=$(basename ${file})
    dest=docs/_proposals/drafts/${name}

    if [[ -f "${dest}" ]]; then    
        printf "You cannot work on ${dest} at this time, the draft is already being worked on. Find the pull request in progress and contribute there."
    fi
done
