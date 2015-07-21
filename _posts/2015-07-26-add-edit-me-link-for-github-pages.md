---
layout: post
title: Adding an Edit Link to Github Pages in Jekyll
tags: [jekyll]
---

While I doubt there will be many people offering to fix my speeling
erros (let alone improve my content), I don't want to miss the chance
that there is a contributor out there. Here's how I added a link to
each page on this Jekyll generated,GitHub pages hosted site.

# GitHub URLs and page.path Values

GitHub uses URLs of the form
"https://github.com/rgardler/rgardler.github.io/edit/master/_posts/2015-07-18-adding_twitter_share_widget_to_jekyll_pages.md"
to edit pages in the browser. Users visiting this page will be invited
to log in to GitHub and, if necessary, they will be asked to fork the
repository. Once forked they can edit the file and make pull requests.

So, all we need to do, is add a link to each page that points to the
appropriate file on GitHub. The "page.path" property is what we need
to do this. It provides the path to the source file that generated the
page.

To create an edit link simply add the following HTML to your page.html
and post.html templates as required:

{% highlight html %}
{% raw %}
<div class="actions">
  <a href="https://github.com/rgardler/rgardler.github.io/edit/master/{{ page.path }}">Edit this page</a>
</div>
{% endraw %}
{% endhighlight %}

And add some styling, I simply used the following:

{% highlight css %}
.actions {
  float:right;
}
{% endhighlight %}