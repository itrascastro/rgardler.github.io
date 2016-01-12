---
layout: post
title: Adding Related Posts to Jekyll Blogs
tags: [jekyll]
---

Stickyness is important on any site. Providing easy access to related
posts is one way to improve stickyness. Here's a simple way to achieve
this on a Jekyll powered blog.

## Using Tags

One of the easiest ways of relating posts to use tags. On a site that
doesn't have too many posts we can iterate over each of the posts and
look to see if they share a tag with the current post. 

Couple of items to be careful of:

  * We only want to display each post once, so we need to break as soon as we find a matching tag
  * We want to make sure we are not including the current post

Here's how:

{% highlight liquid %}
{% raw %}
<ul>
  {% for post in site.posts %}
    {% if post.url != page.url %}
      {% for tag in page.tags %}
        {% if post.tags contains tag %}
          <li><a href="{{ post.url }}">{{ post.title }}</a></li>
          {% break %}
        {% endif %}
      {% endfor %}
    {% endif %}
  {% endfor %}
</ul>
{% endraw %}
{% endhighlight %}
