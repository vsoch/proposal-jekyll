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
This includes details like the site title and basename, and colors. The default uses
[these colors](https://colorhunt.co/palette/001e6c0353975089c6ffaa4c) and you might explore
and update the colors in the _config.yaml to your liking!

### 3. Deploy

You'll then want to trigger the dispatch event workflow that will take the docs
folder and deploy on GitHub pages. We keep the two separate so proposals can
go into main and via pull requests, and we can always update the pages site
without merging anything.

**under development**

### 4. Submit

To submit a proposal, open a pull request to the repository. The markdown file should
be clearly named under [proposals](proposals). You don't need to add front end matter (yet)
as this will be automatically added.

### 5. Develop

Depending on how you installed jekyll, and this would be in [docs](docs) or your
cloned GitHub pages branch:

```bash
jekyll serve
# or
bundle exec jekyll serve
```
