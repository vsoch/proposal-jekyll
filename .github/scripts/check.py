#!/usr/bin/env python3

# This script checks for duplicates of changed files

import argparse
import os
import json
import re
import sys
import requests
import tempfile
from github import Github


def get_parser():
    parser = argparse.ArgumentParser(description="Proposals Check Client")

    description = "Check proposal drafts"
    subparsers = parser.add_subparsers(
        help="actions",
        title="actions",
        description=description,
        dest="command",
    )

    duplicate = subparsers.add_parser("duplicate", help="check for duplicates")

    for command in [duplicate]:
        command.add_argument(
            "files", help="the drafts to consider (changed files)", nargs="*"
        )
    return parser


def read_json(filename):
    with open(filename, "r") as fd:
        content = json.loads(fd.read())
    return content


def check_duplicates(files):

    # First get list of changed files in pull requests
    gh = Github(os.getenv("GITHUB_TOKEN"))
    events_path = os.getenv("GITHUB_EVENT_PATH")
    event = read_json(events_path)
    branch_label = event["pull_request"]["head"]["label"]  # author:branch
    branch_name = branch_label.split(":")[-1]
    repo_name = event["repository"]["full_name"]
    repo = gh.get_repo(repo_name)
    number = event["pull_request"]["number"]
    prs = repo.get_pulls(state="open", sort="created")

    worked_on = []
    lookup = {}
    for pr in prs:
        # Skip this PR
        if pr.number == number:
            print("Skipping #%s" % pr.number)
            continue
        print("Checking #%s" % pr.number)
        response = requests.get(
            "https://api.github.com/repos/%s/pulls/%s/files" % (repo_name, pr.number)
        )
        found = [
            x["filename"]
            for x in response.json()
            if x["status"] in ["added", "modified"]
        ]
        for file in found:
            lookup[file] = pr.number
        worked_on += found

    worked_on = set(worked_on)
    for file in files:
        dirname = os.path.dirname(file)
        if not dirname.endswith("proposals"):
            continue

        if file in worked_on:
            pr_number = lookup[file]
            sys.exit("%s is already being worked on in PR # %s" % (file, pr_number))


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
    if args.command == "duplicate":
        check_duplicates(args.files)


if __name__ == "__main__":
    main()
