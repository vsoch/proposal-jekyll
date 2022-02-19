#!/usr/bin/env python3

# This script does the following.
# 1. Takes in a space separated list of changed files
# 2. For each changed file, adds a header (title) based on the filename
# 3. Sets output for the prepared files to move into the site

import argparse
import os
import json
import sys
import tempfile


def read_file(filename):
    with open(filename, "r") as fd:
        content = fd.read()
    return content

# Templates

draft_template = """---
title: %s
layout: proposal
tags: 
 - draft
---"""


def get_parser():
    parser = argparse.ArgumentParser(description="Proposals Parsing Client")

    description = "Prepare proposal drafts"
    subparsers = parser.add_subparsers(
        help="actions",
        title="actions",
        description=description,
        dest="command",
    )

    draft = subparsers.add_parser("draft", help="prepare drafts")
    draft.add_argument("files", help="the drafts to consider (changed files)")
    return parser

def prepare_drafts(files):

    tmpdir = tempfile.mkdtemp()
    final_files = []
    for filename in files:
        if not os.path.exists(filename):
            print("%s does not exist, skipping!" % filename)
            continue
        dirname = os.path.basename(os.path.dirname(filename))
        if dirname != "proposals":
            print("%s is not a proposal, skipping." % filename)

        # Check that we end in markdown
        if not filename.endswith('md'):
            print("%s does not end in .md, skipping." % filename)
            continue

        # and only have lowercase and -
        basename = os.path.basename(filename)
        if not re.search("^[a-z0-9-]*$", basename):
            print("%s contains invalid characters: only lowercase letters, numbers, and - are allowed!" % basename)
            continue

        # Remove extension and split by -
        title = " ".join([x.capitalize() for x in basename.split('.', 1)[0].split('-')])

        # Prepare header
        template = draft_template % title
        content = read_file(filename)
        template = template + "\n\n" + content
        
        # Write to final location
        tmppath = os.path.join(tmpfile, basename)
        with open(tmppath, 'w') as fd:
            fd.write(template)
        final_files.append(tmppath)

    # When we have final files, set in environment
    print("::set-output name=proposals::$%s" % " ".join(final_files)


def main():
    parser = get_parser()

    def help(return_code=0):
        parser.print_help()
        sys.exit(return_code)

    # If an error occurs while parsing the arguments, the interpreter will exit with value 2
    args, extra = parser.parse_known_args()
    if not args.command:
        help()

    # Prepare drafts
    if args.command == "draft":
        prepare_drafts(args.files)


if __name__ == "__main__":
    main()
