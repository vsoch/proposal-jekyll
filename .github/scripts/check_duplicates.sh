#!/bin/bash

# Check for a duplicate draft on PR open or reopen.

set -e

# Either get proposals from action, or on reopen, derive
if [[ "${proposals}" = "" ]]; then
    for file in $(git diff --diff-filter=A --name-only main); do
        name=$(basename ${file})
        dir=$(dirname ${file})
        if [[ "${dir}" == "proposals" ]]; then
            printf "Including $file\n"  
            proposals="$name $proposals"
        else
            printf "Skipping adding $file, not in proposals\n"  
        fi
    done
fi
python .github/scripts/check.py ${proposals}
