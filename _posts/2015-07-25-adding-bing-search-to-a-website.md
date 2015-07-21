---
layout: post
title: Adding a Bing Search Box to a Website
tags: [bing]
---

GitHub pages provide no means for search and you can't use Jekyll
plugins, yet a site needs a search. So here's a way to provide a Bing
searchbox to a Jekyll generated website. Of course a Google, Yahoo! or
whatever searchbox in some other form of website is just as easy.

First add the following HTML to a suitable location in your
default.html layout.

{% highlight html %}
{% raw %}
<div class="searchbox">
  <form method="get" action="http://www.bing.com/search">
    <input id="searchinput" type="text" placeholder="Search..." name="q" value="" /> 
    <input type="hidden" name="q1" value="site:{{site.production_url}}" />
  </form>
</div>
{% endraw %}
{% endhighlight %}

Then add some CSS to your style.css file, in my case I used the
following:

{% highlight css %}
.searchbox {
  float:right;
  width: 20em;
  padding: 3px;
  border:0;
  outline: none;
  vertical-align: bottom;
}

#searchinput {
  width:100%;
}
{% endhighlight %}

And your done.