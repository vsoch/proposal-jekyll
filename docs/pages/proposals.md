---
layout: page
title: Proposals
permalink: /proposals/
---

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

Need help submitting or updating a proposal? See the [repository README]({{ site.repo }})

