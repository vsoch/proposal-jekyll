#!/bin/bash

# Check for a duplicate draft on PR open or reopen.

set -e

# Either get proposals from action, or on reopen, derive
for file in ${proposals}; do
    name=$(basename ${file})
    dir=$(dirname ${file})
    if [[ "${dir}" == "proposals" ]]; then
        printf "Including $file\n"  
        proposals="$name $proposals"
    else
        printf "Skipping adding $file, not in proposals\n"  
    fi
done
export proposals
python .github/scripts/check.py duplicate ${proposals}
