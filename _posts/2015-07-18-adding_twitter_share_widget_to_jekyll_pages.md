---
layout: post
title: Adding a Twitter Button to a Jekyll Blog
tags: [jekyll, social]
---

Jekyll Bootstrap is great, it got me up and running with this blog in
next to no time. However, it is no longer maintained and doesn't
currently come with a a social sharing widget. Here's how I added one
to this site.

## Implementing in Jekyll Bootsrap ##

I looked around to see if there was an easy way to implement this in
Jekyll Bootstrap. There is an incomplete implementation and a few pull
requests relating to this on the GitHub site. There are also some
blogs about how to do it.

However, I decided not to use the Jekyll Bootstrap approach since the
addiiton of social sharing widgets is really easy - most sites give
you an online tool to create the button you
want. E.g. [Twitter](https://about.twitter.com/resources/buttons)

## Adding the Social Share Button ##

Having generated the HTML code using the
[Twitter](https://about.twitter.com/resources/buttons) buttton
generator I simply pasted it in to 'index.md' so that it would appear
in the list of posts there. I modified the HTML generated as follows:

  * Added a &lt;span class="socialshare"&gt; element and some matching CSS
  * Made 'data-text' the value of 'post.title'
  * Made the value of data-hashtags the value of 'post.tags[0]'

Now there is a working widget it's time to put it onto the post page
as well as the index page. This is simply a matter of cuttting and
pasting the html into '_includes/themese/twitter/post.html' and adding
some appropriate CSS. I needed to tweak the HTML as follows:

  * Made 'data-text' the value of 'page.title'
  * Made the value of data-hashtags the value of 'page.tags[0]'
  
I chose to add the twitter widget in two locations, one at the top and
one at the bottom, by the tags list.

## See the Changes on GitHub ##

You can view the code changes on [GitHub](https://github.com/rgardler/rgardler.github.io/commit/abef63daa9c1761be8de2fb939e84993c8141c3b).

## Other Twitter Stuff I (or maybe you) Could Do ##

  * Add an include for the social share which can take a parameter for the share text. This would allow pages to include callouts that had their own share widget.
  * Add a Buffer widget
  * Add a [tweets widget](https://twitter.com/settings/widgets/new) to the home page
  * Add a page with a bunch of useful [tweet widgets](https://twitter.com/settings/widgets/new)