---
title: About
permalink: /about/
---

This is a template and actions to help you to collaboratively work on things.
With proposals-jekyll:

1. New pull requests open on the repository are considered proposals.
2. A new proposal will trigger a workflow to add the draft to the web interface
3. Merging a pull request will add the draft as a final "approved" state, in which case it can be worked on further via PR.

This means the following workflows:

 1. on PR open, update file on gh-pages with draft state
 2. on PR close, if file not already in main, remove from gh-pages
 3. on PR merge, also update file on gh-pages with inprogress state

It is based on the [tw-jekyll theme](https://vsoch.github.com/tw-jekyll/) for a Tailwind jekyll theme.
See the [respository]({{ site.repo }}) for more details.

## Support

If you need help, please don't hesitate to [open an issue](https://www.github.com/{{ site.github_user }}/{{ site.github_repo }}).

