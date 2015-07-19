---
layout: post
title: Adding a CSS GitHUb Ribbon to a Jekyll Site
tags: [jekyll, css]
---

It is possible that someone might want to reuse some of the code on
this blog, or maybe the Jekyll configuration that drives it. For this
reason I've added an HTML+CSS "Fork Me on GitHub" ribbon, here's how.

## The Inspiration

There's a great tutorial from [Daniel Perez
Alvarez](https://unindented.org/articles/github-ribbon-using-css-transforms/). This
is all I needed to make it happen. If you want to know more about how
this works then chek out Daniel's detailed tutorial.

## The Implementaiton

For my blog all I needed to do was to add the following HTML to the
body of my default.html template:

{% highlight html %}
{% raw %}
<div class="ribbon">
  <a href="https://github.com/rgardler/rgardler.github.io">Fork me on GitHub</a>
</div>
{% endraw %}
{% endhighlight %}

Then a little styling is needed. This is almost identical to Daniels
CSS, the changes I made place my ribbon on the top right rather than
top left. These changes are simply to change the position to 'right'
rather than left and to rotate +45 degrees rather than -45 degrees.

{% highlight css %}
.ribbon {
  background-color: #a00;
  overflow: hidden;
  white-space: nowrap;
  position: absolute;
  right: -50px;
  top: 40px;
  -webkit-transform: rotate(45deg);
     -moz-transform: rotate(45deg);
      -ms-transform: rotate(45deg);
       -o-transform: rotate(45deg);
          transform: rotate(45deg);
   -webkit-box-shadow: 0 0 10px #888;
     -moz-box-shadow: 0 0 10px #888;
          box-shadow: 0 0 10px #888;
  text-shadow: 0 0 5px #444;
}

.ribbon a {
  border: 1px solid #faa;
  color: #fff;
  display: block;
  font: bold 81.25% 'Helvetica Neue', Helvetica, Arial, sans-serif;
  margin: 1px 0;
  padding: 10px 50px;
  text-align: center;
  text-decoration: none;
}
{% endhighlight %}