#!/bin/bash

# Check for a duplicate draft on PR open or reopen.

set -e

# Either get proposals from action, or on reopen, derive
finalset=""
for file in ${proposals}; do
    name=$(basename ${file})
    dir=$(basename $(dirname ${file}))
    if [[ "${dir}" == "proposals" ]]; then
        printf "Including $file\n"  
        finalset="$file $finalset"
    else
        printf "Skipping adding $file, not in proposals\n"  
    fi
done
export proposals=$finalset
python .github/scripts/check.py duplicate ${proposals}
