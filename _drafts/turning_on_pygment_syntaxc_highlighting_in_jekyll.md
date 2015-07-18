---
layout: post
title: Turning on Pygment Syntax Highlighting in Jekyll
---

FIXME: this isn't working for some reason

By default Pygment Syntax Highlighting was not enabled in my Jekyll
Bootstrap site. Here's how I fixed it.

Simply add 'highlighter: pygments' to your '_config.yml' file.

Now you add content such as:

{% highlight ruby %}
def foo
  puts 'foo'
end
{% endhighlight %}
