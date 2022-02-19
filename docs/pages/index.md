---
layout: page
title: Proposals-Jekyll Theme
permalink: /
---

## Welcome to Proposals Jekyll!

<br>

This is a started template with additional functionality added to [tw-jekyll](https://vsoch.github.com/tw-jekyll/) 
to provide you or your organization an automated process to create and review proposals.

{% assign number_proposals = site.proposals | size %}
{% if number_proposals > 0 %}
## Proposals

<br>

{% for proposal in site.proposals %}
 - [{{ proposal.title }}]({{ site.baseurl }}{{ proposal.url }})
{% endfor %}

{% include callout.html text="Hey, check out our proposals above! We definitely are looking forward to your feedback." %}

{% else %}

{% include callout.html text="We don't have any proposals yet - come back soon!" %}

{% endif %}

For getting started with development, see the {% include doc.html name="Getting Started" path="getting-started" %} page. Would you like to request a feature or contribute? [Open an issue]({{ site.repo }}/issues)

