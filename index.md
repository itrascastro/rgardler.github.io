---
layout: page
title: Hmmmm....
tagline: thoughts that won't change the world
excerpt: Notes on my experiments with technology. My lessons learned will be documented here, warts and all. Maybe it will be useful to someone.
---
{% include JB/setup %}

<div class="posts">
  {% for post in site.posts %}
    <div class="post">
	<h3 class="title"><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
	<span class="date">{{ post.date | date_to_string }}</span></h3>
	<span class="socialshare">
<a href="https://twitter.com/share" class="twitter-share-button" data-text="{{ post.title }}" data-via="rgardler" data-size="large" data-count="none" data-hashtags="{{ post.tags[0] }}">Tweet</a> <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script></span>
	{{ post.excerpt }}
	<a class="more" href="{{ BASE_PATH }}{{ post.url }}">Read More...</a>
    </div>
  {% endfor %}
</div>


