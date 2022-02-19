---
layout: page
title: Proposals-Jekyll Theme
permalink: /
---

# Welcome to Proposals Jekyll!

This is a started template with additional functionality added to [tw-jekyll](https://vsoch.github.com/tw-jekyll/) 
to provide you or your organization an automated process to create and review proposals.

{% if site.proposals %}
## Proposals

<br>

{% for proposal in site.proposals %}
 - [{{ proposal.title }}]({{ site.baseurl }}{{ proposal.url }})
{% endfor %}

{% endif %}

{% include callout.html text="Hey, check out our proposals above! We definitely are looking forward to your feedback." %}

For getting started with development, see the {% include doc.html name="Getting Started" path="getting-started" %} page. Would you like to request a feature or contribute? [Open an issue]({{ site.repo }}/issues)

