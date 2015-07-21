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
	<h3 class="title"><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></h3>
	{{ post.excerpt }}
	<span class="date">Posted: {{ post.date | date_to_string }}</span>
	<a class="more" href="{{ BASE_PATH }}{{ post.url }}">Read More...</a>
    </div>
  {% endfor %}
</div>


