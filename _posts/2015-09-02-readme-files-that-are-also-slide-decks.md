---
layout: post
title: Readme Files That Are Also Slide Decks
tags: [docker, containers]
---

I hate doing work twice, don't you? That's why I built a Docker
container that allows me to write readme files that are also slide
decks. Here's how to do it with Docker and Reveal.js.

# Objective

I do lots of demo's. I like to make the code available for those who
find them useful. This means I need to write documentation for the
code as well slides to support delivery of the demo's. Most of the
content is duplicated across these two documents. They differ only in
the level of detail needed. The written word needs full details, the
presentation deck needs high level points that I will talk to.

Since the convention, these days, is to weite a README.md file in the
root of your projects wouldn't it be great if we could use Markdown to
write a single document that is useful in both cases?

Well now I can. Here's how.

# Reveal.js

Reveal.js is a framework for building slide decks in Markdown (or HTML
if you prefer). It's not as feature rich as something like Powerpoint
but it's pretty good, certainly good enough for the kind of
presentation I do. [Take a look](http://revealjs.jit.su/).

I've packaged Reveal.js as a Docker container using ONBUILD to allow
it to be reused for building self contained presentations that will be
delivered via the browser. I'll describe how to do this in a moment,
first a little about what this means for writing slide and longform
content.

## Writing slides

By default slides come from a readme.md file and looks like this:

{% highlight bash %}
# This is the first slide

### Author
### Contact Details

---

# Separating Slides

Slides are separated by '---' at the start of a line

--

# Child Slides

You can also have "child slides"

Transition from the bottom when navigating with 'space'

Can be skipped by navigating with 'right arrow'

--

Child slides are separated from the "parent
slide" with '--'

{% endhighlight %}

## Writing Long Form content

You can add long form content by adding a subheading in the form '##
Details'. Content that follows this heading will not be displayed on
the slide, but will be availble in any other markdown rendering of the
content. A slide with longform details would therefore look like this:

{% highlight bash %}
# Slide title

Some slide content

A little more content

## Details

This is the longform description. It can contain any markdown you
want.
{% endhighlight %}

This results in a document that has some summary information at the
start of each section followed by the expanded detail. This format not
only allows us to maintain slides and longform in the same document,
but it also facilitates speed reading of the longform document.

## Presenting Slides

The following command starts the revealjs container with some default content
(which is actually the readme file of the
[corresponding GitHub project](https://github.com/rgardler/docker-demos/tree/master/revealjs))

{% highlight bash %}bash
docker run --rm -p 8000:8000 rgardler/revealjs
{% endhighlight %}

Now point your browser at http://yourhost:8000

## Creating Your Own Slides

Creating your own presentation container is really easy. First, create
a Dockerfile:

{% highlight dockerfile %}
FROM rgardler/revealjs
{% endhighlight %}

Now create your readme.md content as described above.

Build your container:

{% highlight bash %}
docker build slides .
{% endhighlight %}

Start your container:

{% highlight bash %}
docker run --rm -p 8000:8000 slides
{% endhighlight %}

Navigate to your deck:

{% highlight bash %}
http://localhost:8000
{% endhighlight %}

You can, of course, use your Dockerfile to make your container
behave differently. For example you might choose to use a different
markdown file for your slides:

{% highlight bash %}
COPY docs/introduction.md /revealjs/slides.md
{% endhighlight %}

Or you could Reveal.js replace index.html with your own version in
order to customize the behaviour of reveal.js.

# Doing More

There is much more to reveal.js than this I've covered here See the
[reveal.js documentation](https://github.com/hakimel/reveal.js) for
more.



