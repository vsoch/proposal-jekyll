# Proposals Jekyll Theme

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

**under development**

## Quick Start

1. Fork the repository
2. Make changes to the _config.yaml and templates in [docs](docs)
3. Push to your branch and run the create-pages workflow
4. Turn on GitHub pages in your settings
5. Add a proposal via PR, and merge when it's done!

## Usage

### 1. Get the code

You can clone the repository right to where you want to host the docs:

```bash
git clone https://github.com/vsoch/proposal-jekyll
cd proposal-jekyll
```

Note that we store the main interface under [docs](docs) here.

### 2. Customize

#### Jekyll Config

To edit configuration values, customize the [_config.yml](https://github.com/vsoch/proposal-jekyll/blob/main/_config.yml).
This includes details like the site title and basename, and colors.

### 3. Deploy

You'll then want to trigger the dispatch event workflow that will take the docs
folder and deploy on GitHub pages. We keep the two separate so proposals can
go into main and via pull requests, and we can always update the pages site
without merging anything.

### 4. Submit

To submit a proposal, you will open a pull request to the repository. 

1. The markdown file should be added under [proposals](proposals).
2. The name of the file should correspond to the title, e.g., "Automated Container Builds" should be `proposals/automated-container-builds.md`. Only lowercase letters, numbers, and `-` are allowed in the name. You don't need to write the title in the document - it will be added by the automation.
3. You don't need to add front end matter, as it will be automatically added.

Once you've prepared the markdown file, open a pull request to the repository.
If you aren't a contributor, when the workflow is approved it will add the draft to
the site.

### 5. Develop

Depending on how you installed jekyll, and this would be in [docs](docs) or your
cloned GitHub pages branch:

```bash
jekyll serve
# or
bundle exec jekyll serve
```

If you want to take the [docs](docs) folder in the main branch and completely wipe
your current template (start fresh) you can run the dispatch event workflow
again to create the pages. Do this with caution! Make a backup of your proposals pages first.

## TODO

- fix navigation to include link to proposals home
- test workflows needed to add proposals

