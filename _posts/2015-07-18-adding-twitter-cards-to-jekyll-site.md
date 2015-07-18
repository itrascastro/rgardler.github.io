---
layout: post
title: Adding Twitter Cards to a Jekyll Site
tags : [jekyll, twitter]
---

[Twitter cards](https://dev.twitter.com/cards/overview) enable you to
present more information to Twitter users who recieve a link to your
site. Adding them to a Jekyll generated site is easy.

For my site all I needed to do was edit
'_include/themese/twitter/default.html' and add the following lines to
the head section:

{% highlight html %}
<!-- Twitter Cards -->
<meta name="twitter:card" content="summary" />
<meta name="twitter:site" content="@rgardler" />
<meta name="twitter:title" content="{{ page.title }}" />
<meta name="twitter:description" content="{{ page.excerpt | strip_html }}" />
<!-- meta name="twitter:image" content="https://farm6.staticflickr.com/5510/14338202952_93595258ff_z.jpg"  -->
{% endhighlight %}

Since most of my pages (as opposed to posts) don't have content they
don't have excerpts. This can be resolved by adding an excerpt value
to the page Front Matter.

#### TODO ####

At present my site doesn't contain any pictures, but it would be a
good idea to include the "twitter:image" tag when a post contains an
image.