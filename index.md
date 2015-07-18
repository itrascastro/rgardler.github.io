---
layout: page
title: Hmmmm....
tagline: thoughts that won't change the world
---
{% include JB/setup %}

<div class="posts">
  {% for post in site.posts %}
    <div class="post">
	<h3>{{ post.title }} <span class="date">{{ post.date | date_to_string }}</span></h3>
	{{ post.excerpt }}
        <a class="more" href="{{ BASE_PATH }}{{ post.url }}">Read More...</a>
    </div>
  {% endfor %}
</div>


