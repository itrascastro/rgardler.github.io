---
layout: post
title: Turning on Pygment Syntax Highlighting in Jekyll
---

By default Pygment Syntax Highlighting was not enabled in my Jekyll
Bootstrap site. Here's how I fixed it.

First, add 'highlighter: pygments' to your '_config.yml' file.

Second, generate the syntax css file with:

{% highlight bash %}
pygmentize -S default -f html > assetts/themes/twitter/css/syntax.css
{% endhighlight %}

Alternatively you can pull the syntax.css file from my CSS repository
(which was generated with the above command).

Finally, add a link to this stylesheet in '_includes/themes/twitter/default.html':

{% highlight html %}
<link href="{{ ASSET_PATH }}/css/syntax.css" rel="stylesheet" type="text/css" media="all">
{% endhighlight %}

Now you add content such as:

{% highlight liquid %}
{% raw %}
{% highlight ruby %}
def foo
  puts 'foo'
end
{% endhighlight %}
{% endraw %}
{% endhighlight %}

#### Bonus: Showing Highlighter Syntax on your Pages ####

If you are wondering how you can show highlighter syntax, like that
above in your pages the secret is the 'raw' template.