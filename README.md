## Proposals Jekyll Theme

**⭐️ Welcome to Proposals Jekyll! ⭐️**

This is a template and actions to help you to collaboratively work on things.
With proposals-jekyll:

1. New pull requests open on the repository are considered proposals.
2. If you open a pull request that already has a PR open it will not be allowed.
3. A new or updated proposal will trigger a workflow to add the draft to the web interface
3. Merging a pull request will add the draft as a final "approved" state, and remove from drafts, in which case it can be worked on further via PR.

Read about [#workflows](Workflows), [Working With Proposals](#working-with-proposals), or [How to setup](#setup) a site next.

### Quick Start

1. Fork the repository
2. Make changes to the _config.yaml and templates in [docs](https://github.com/vsoch/proposal-jekyll/tree/main/docs)
3. Push to your branch and run the create-pages workflow
4. Turn on GitHub pages in your settings
5. Add a proposal via PR, and merge when it's done!

### Working with Proposals

If you haven't created your site yet, see [setup](#setup) first.

#### How do I add a new proposal?

To submit a proposal, you will open a pull request to the repository. 

1. The markdown file should be added under [proposals](https://github.com/vsoch/proposal-jekyll/tree/main/proposals) at the top level.
2. The name of the file should correspond to the title, e.g., "Automated Container Builds" should be `proposals/automated-container-builds.md`. Only lowercase letters, numbers, and `-` are allowed in the name.
3. You should not write the title in the document - it will be added by the automation.
4. You should not add any front end matter, as it will be automatically added.

Once you've prepared the markdown file, open a pull request to the repository.
If you aren't a contributor, when the workflow is approved it will add the draft to
the site as long as someone else isn't making changes to the same proposal. If this
happens the automation will fail, and you should find the other pull request to work
on collaboratively instead.

#### How do I update an existing proposal?

All proposals live in [proposals](proposals) on the main branch. When you want to edit
an existing one, simply make changes and open another pull request. By way of having
the same filename, the proposal on the site will be updated to return to a draft state.
While you are working on the draft, the previous approved proposal (if applicable)
will not be touched. The reason is because if you close the pull request we wouldn't
want to alter or remove it.

#### How do I delete a proposal?

To delete a proposal, simple open a pull request to delete the file
from the main branch. For the sake of caution it won't be deleted on the PR, but when it is merged
into main.

#### What happens if close a pull request?

If your pull request created a draft, we delete the draft. We do not
delete and previously approved version of the proposal.

#### What happens if two pull requests are working on the same file?

By default, we are only allowed one draft in progress at once. If you open
a pull request and the draft is being worked on somewhere else,
the PR will fail. You should thus check before you open a PR that there
isn't already a draft in progress!

### Workflows

To enable the proposals collaboration automation we have the following workflows:

 1. on PR open, update file on gh-pages with draft state
 2. on PR close, if file not already in main, remove from gh-pages
 3. on PR merge, also update file on gh-pages with inprogress state

They are described in more detail below.

#### Open Pull Request to Create Draft

When you open a pull request, given that it's approved by a maintainer (or you
are a contributor and don't need that) we run a workflow that finds new or changed files
in the `proposals` directory of the main branch, and then adds them as drafts to the website.
This means on GitHub Pages (gh-pages branch typically) we add them to `_proposals/drafts` and
there is a draft tag included.

#### Close Pull Request to Clean Up

Not all changes go through, and this is ok! If you open a pull request
and no longer want to work on the draft, we will remove the draft from 
the github pages.

### Setup

#### 1. Get the code

You can clone the repository right to where you want to host the docs:

```bash
git clone https://github.com/vsoch/proposal-jekyll
cd proposal-jekyll
```

Note that we store the main interface under [docs](https://github.com/vsoch/proposal-jekyll/tree/main/docs) here.

#### 2. Customize

To edit configuration values, customize the [_config.yml](https://github.com/vsoch/proposal-jekyll/blob/main/_config.yml).
This includes details like the site title and basename, and colors.

#### 3. Deploy

You'll then want to trigger the dispatch event workflow that will take the docs
folder and deploy on GitHub pages. We keep the two separate so proposals can
go into main and via pull requests, and we can always update the pages site
without merging anything.

#### 4. Develop

Depending on how you installed jekyll, and this would be in [docs](https://github.com/vsoch/proposal-jekyll/tree/main/docs) or your
cloned GitHub pages branch:

```bash
jekyll serve
# or
bundle exec jekyll serve
```

If you want to take the [docs](https://github.com/vsoch/proposal-jekyll/tree/main/docs) folder in the main branch and completely wipe
your current template (start fresh) you can run the dispatch event workflow
again to create the pages. Do this with caution! Make a backup of your proposals pages first.
