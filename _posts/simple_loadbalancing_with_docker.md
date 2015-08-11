---
layout post
title: Simple Load Balancing for Docker Containers
tags: [docker, load balancing]
---

Load balancing your web applications is important if you are growing
(or have spikes of) traffic. Here's how to set up a very simple load
balanced solution in Docker Containers using HA Proxy.

# The Application

For illustrative purposes we'll keep it simple. Our
[application](https://github.com/rgardler/AzureDevTestDeploy) is a PHP
webapp that makes a REST call to a Java REST API. We want to load
balance the PHP App accross two containers while we have a single REST
container.

This is a fairly artificial environment since all of our containers
are running on the same host so we are not providing any form of
scalabilty or failover. However, it's a good first step in exploring
our load balancing options.

I'm going to use the
[tutum/haproxy](https://hub.docker.com/r/tutum/haproxy/) container
from Docker Registry. This is a great pre-configured container
available from the Docker Registry. It provides a wealth of
configuration options, but I'm just going to use it in its default
configuration. Furthermore, I'm not going to provide any form of
dynamic discovery for my webapp containers. This is another limitation
in that we can't dynamically add new webapp containers. Again, this is
a good first step, not an end goal.

# Deploying the App

To deploy our application without load balancing we run the following
two commands.

{% highlight bash %}
docker run -t -d -p 8080:8080 --name=stage_rest rest
docker run -t -d -p 80:80 --link stage_rest:rest --name=stage_web web
{% endhighlight %}

NOTE: For full details on how to build the containers see the
[readme.md file in
GitHub](https://github.com/rgardler/AzureDevTestDeploy):

In order to add load balancing we run the following:

{% highlight bash %}
docker run -t -d -p 8080:8080 --name=stage_rest rest
docker run -t -d --link stage_rest:rest --name=stage_web1 web
docker run -t -d --link stage_rest:rest --name=stage_web2 web
docker run -d -p 80:80 --name=stage_web --link stage_web1:stage_web1 --link stage_web2:stage_web2 tutum/haproxy
{% endhighlight %}

That's it!

