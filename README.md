## Proposals Jekyll Theme

**⭐️ Welcome to Proposals Jekyll! ⭐️**

This is a template and actions to help you to collaboratively work on things.
With proposals-jekyll:

1. New pull requests open on the repository are considered proposals.
2. A new proposal will trigger a workflow to add the draft to the web interface
3. Merging a pull request will add the draft as a final "approved" state, in which case it can be worked on further via PR.

This means the following workflows:

 1. on PR open, update file on gh-pages with draft state
 2. on PR close, if file not already in main, remove from gh-pages
 3. on PR merge, also update file on gh-pages with inprogress state

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

1. The markdown file should be added under [proposals](https://github.com/vsoch/proposal-jekyll/tree/main/proposals).
2. The name of the file should correspond to the title, e.g., "Automated Container Builds" should be `proposals/automated-container-builds.md`. Only lowercase letters, numbers, and `-` are allowed in the name. You don't need to write the title in the document - it will be added by the automation.
3. You don't need to add front end matter, as it will be automatically added.

Once you've prepared the markdown file, open a pull request to the repository.
If you aren't a contributor, when the workflow is approved it will add the draft to
the site.

#### How do I update an existing proposal?

All proposals live in [proposals](proposals) on the main branch. When you want to edit
an existing one, simply make changes and open another pull request. By way of having
the same filename, the proposal on the site will be updated to return to a draft state.

#### How do I delete a proposal?

To delete a proposal, simple open a pull request to delete the file
from the main branch. It won't be deleted on the PR, but when it is merged
into main.

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
