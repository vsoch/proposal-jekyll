---
layout: page
title: Proposals-Jekyll Theme
permalink: /
---

# Welcome to Proposals Jekyll!

This is a started template with additional functionality added to [tw-jekyll](https://vsoch.github.com/tw-jekyll/) 
to provide you or your organization an automated process to create and review proposals.

## Proposals

<br>

{% for proposal in site.proposals %}
 - [{{ proposal.title }}]({{ site.baseurl }}{{ proposal.url }})
{% endfor %}

{% include callout.html text="I fell in love with this template as soon as I saw it, and knew that I wanted others to be empowered to use it." %}

For getting started with development, see the {% include doc.html name="Getting Started" path="getting-started" %} page. Would you like to request a feature or contribute? [Open an issue]({{ site.repo }}/issues)

