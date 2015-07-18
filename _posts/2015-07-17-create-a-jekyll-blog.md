---
layout: post
title: Creating a Jekyll Blog
tags : [jekyll]
---

I've not maintained a blog for a number of years, maybe now is the
time to change that. My goal withthis blog is not to create and
maintain high quality content, I have other outputs for the polished
stuff. This is a place for me to keep notes, mostly for myself to come
back to, but maybe others will find them useful as they explore the
same technologies as I do.

So here's the first note, how this blog was created:

  * [Jekyll](http://jekyllrb.com/) for site generation
  * Hosted on [Github pages](http://pages.github.com)
  * Bootstrapped using [Jekyll Bootstrap](http://jekyllbootstrap.com/)
  * Commenting from [Disqus](https://disqus.com/)
  * Analytics from get [Clicky](http://clicky.com)

## Customizations

[Jekyll Bootstrap](http://jekyllbootstrap.com/) is great, although
unmaintained now. I had a clean looking sight pretty much out of the
box. I made the following customizations:

  * Switched to the "Twitter" theme (edit the files in _layouts directory replacing the bootstrap3 theme references with twitter ones)
  * Removes the Categories and Pages pages (removed the approprite *.html files), which also made the navigation menu less cluttered
  * Edited index.html to show an index of posts (with excerpts)

## Things to Do

This is a good start and I'm happy with it, but there is more to
do. Here's some ideas:

  * [DONE] Use a [Docker container to enable previewing of the Jekyll site]({{ BASE_PATH }}/2015/07/18/docker-container-for-jekyll) on any dev machine
  * Add social sharing buttons (at least to twitter)
  * [DONE] Add [Twitter cards]({{ BASE_PATH }}/2015/07/18/adding-twitter-cards-to-jekyll-site)
  * Add an about page
  * Add links to RSS and Atom feeds
  * Make the page.excerpt a meta="description" tag in the head