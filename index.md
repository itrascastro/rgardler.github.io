---
layout: page
title: Hmmmm....
tagline: thoughts that won't change the world
---
{% include JB/setup %}

<ul class="posts">
  {% for post in site.posts %}
    <li>
	<span>{{ post.date | date_to_string }}</span> &raquo; 
	<a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a>
	{{ post.excerpt }}
	{% unless post.tags == empty %}
	  <ul class="tag_box inline">
	      <li><i class="icon-tags"></i></li>
	      {% assign tags_list = post.tags %}
	      {% include JB/tags_list %}
  	  </ul>
	{% endunless %}  
    </li>
  {% endfor %}
</ul>


