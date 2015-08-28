---
layout: post
title: Docker Cleanup Commands
tags: [docker]
---

When working with Docker containers it is easy to find yourself will
unused containers littering your Docker hosts, especially in a
development envronment. Here are a bunch of commands that are useful
for cleaning up after yourself.

# Docker cleanup commands

Kill all running containers
{% highlight bash %}
docker kill $(docker ps -q)
{% endhighlight %}

Delete all stopped containers (including data-only containers)

{% highlight bash %}
docker rm $(docker ps -a -q)
{% endhighlight %}

Delete all 'untagged/dangling' (<none>) images

{% highlight bash %}
docker rmi $(docker images -q -f dangling=true)
{% endhighlight %}

Delete ALL images

{% highlight bash %}
docker rmi $(docker images -q)
{% endhighlight %}

This is my favorite cleanup command. Just set search term to the
common phrase. GB is a good one for cleaning up big containers.

{% highlight bash %}
docker rmi $(docker images | grep ${search_term} | grep -o -E " [0-9,a-f]{12} ")
{% endhighlight %}

To kill allstopped or exited containers, you can try

{% highlight bash %}
docker rm $(docker ps -f status=exited -q)`
{% endhighlight %}

# Docker-machine cleanup command

Force remove all docker-machines
{% highlight bash %}
docker-machine rm -f $(docker-machine ls -q)
{% endhighlight %}

# Credits

While some of these are my own creation, quite a few of these commands
came from[calazan.com](
https://www.calazan.com/docker-cleanup-commands/).