#!/usr/bin/env python3

# This script does the following.
# 1. Takes in a space separated list of changed files
# 2. For each changed file, adds a header (title) based on the filename
# 3. Sets output for the prepared files to move into the site

import argparse
import os
import json
import re
import sys
import tempfile
from github import Github


def read_file(filename):
    with open(filename, "r") as fd:
        content = fd.read()
    return content


def read_json(filename):
    with open(filename, "r") as fd:
        content = json.loads(fd.read())
    return content


# Templates

draft_template = """---
title: %s
layout: proposal
pr: %s
tags: 
 - draft
---"""

approved_template = """---
title: %s
layout: proposal
tags: 
 - inprogress
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
    approved = subparsers.add_parser("approved", help="add approved proposals")
    remove = subparsers.add_parser("remove", help="remove non-existing proposals")

    for command in [draft, approved, remove]:
        command.add_argument(
            "files", help="the drafts to consider (changed files)", nargs="*"
        )
    return parser


def get_title(filename):
    """
    Convert name-of-markdown.md to Name Of Markdown
    """
    basename = os.path.basename(filename)
    return " ".join([x.capitalize() for x in basename.split(".", 1)[0].split("-")])


def is_correct(filename):
    """
    Formatting and sanity checks
    """
    if not os.path.exists(filename):
        print("%s does not exist, skipping!" % filename)
        return False

    dirname = os.path.basename(os.path.dirname(filename))
    if dirname != "proposals":
        print("%s is not a proposal, skipping." % filename)
        return False

    # Check that we end in markdown
    if not filename.endswith("md"):
        print("%s does not end in .md, skipping." % filename)
        return False

    # and only have lowercase and -
    basename = os.path.basename(filename).replace(".md", "")
    if not re.search("^[a-z0-9-]*$", basename):
        print(
            "%s contains invalid characters: only lowercase letters, numbers, and - are allowed!"
            % basename
        )
        return False
    return True


def find_removed(files):
    """
    Only allow removed on merge into main, so it's approved by owners
    """
    removed = []
    for filename in files:
        if not os.path.exists(filename):
            removed.append(filename)
    print("::set-output name=removed::%s" % " ".join(removed))


def prepare_preposals(files, template_string, with_pr=False):
    """
    Generic shared function to prepare proposal files
    """
    tmpdir = tempfile.mkdtemp()
    final_files = []
    for filename in files:

        if not is_correct(filename):
            continue

        # Prepare header
        title = get_title(filename)
        if with_pr:
            pr = get_pull_request()
            template = template_string % (title, pr)
        else:
            template = template_string % title
        content = template + "\n\n" + read_file(filename)

        # Write to final location
        tmppath = os.path.join(tmpdir, os.path.basename(filename))
        with open(tmppath, "w") as fd:
            fd.write(content)
        final_files.append(tmppath)

    # When we have final files, set in environment
    print("::set-output name=proposals::%s" % " ".join(final_files))


def prepare_approved(files):
    """
    Prepare approved (in progress) proposals
    """
    prepare_preposals(files, approved_template, with_pr=False)


def prepare_drafts(files):
    """
    Prepare proposal drafts
    """
    prepare_preposals(files, draft_template, with_pr=True)


def get_pull_request():
    gh = Github(os.getenv("GITHUB_TOKEN"))
    events_path = os.getenv("GITHUB_EVENT_PATH")
    event = read_json(events_path)
    repo_name = event["repository"]["full_name"]
    repo = gh.get_repo(repo_name)
    number = event["pull_request"]["number"]
    return "https://github.com/%s/pull/%s" % (repo_name, number)


def main():
    parser = get_parser()

    def help(return_code=0):
        parser.print_help()
        sys.exit(return_code)

    # If an error occurs while parsing the arguments, the interpreter will exit with value 2
    args, extra = parser.parse_known_args()
    if not args.command:
        help()

    print(args.files)

    # Prepare drafts
    if args.command == "draft":
        prepare_drafts(args.files)
    elif args.command == "approved":
        prepare_approved(args.files)
    elif args.command == "remove":
        find_removed(args.files)


if __name__ == "__main__":
    main()
