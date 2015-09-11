---
layout: post
title: Load Balancing for Docker Containers with HA Proxy
tags: [docker, load balancing]
---

Load balancing is important for many applications. A popular open source load balancer is [HAProxy](http://www.haproxy.org/). Here's how I used an HAProxy container to automatically discover and load balance a simple web application.

# Simple Load Balancing

In an earlier post I created a [Simple Load Balanced Application with Docker]({{ post_url 2015-08-11-simple_loadbalancing_with_docker }}). This used an HAProxy container available in Docker Hub. In sumamry what was needed was:

{% highlight bash %}
docker run -t -d -p 8080:8080 --name=stage_rest rest
docker run -t -d --link stage_rest:rest --name=stage_web1 web
docker run -t -d --link stage_rest:rest --name=stage_web2 web
docker run -d -p 80:80 --name=stage_web --link stage_web1:stage_web1 --link stage_web2:stage_web2 tutum/haproxy
{% endhighlight %}

The problem with this approach is that you can't add new web containers without restarting the proxy container. Not a huge problem but it would be nice if the proxy auto-discovered these containers and removed them when they went offline.

# Dynamically Configured HA Proxy Container

In order to build a proxy that could automatically included or removed web continares as thaey came and went I used another container that can be found in Docker Hub, [eeacms/haproxy](https://hub.docker.com/r/eeacms/haproxy/). This container includes some scripts that automatically configure HAProxy to load balance across available http servers.

In order to test this I used the same demo [application](https://github.com/rgardler/AzureDevTestDeploy) as in the earlier post - a simple PHP web front-end and a Java back-end. In order to more easily test the scaling up and down of the application I also took the opportunity to write a Docker Compose file for the application, which looks like this:

{% highlight yaml %}
lb:
  image: eeacms/haproxy
  ports:
    - "80:80"
    - "1936:1936"
  links:
    - web
  restart: always
web:
  build: web
  links:
    - rest
  restart: always
rest:
  build: java
  ports:
    - "8080:8080"
  restart: always
{% endhighlight %}

No we can start the application with:

{% highlight bash %}
docker-compose up -d
{% endhighlight %}

Visiting http://localhost will show you that the application is working. Refreshing the page will result in the same hostname every time since there is currently only one host. Create another two web hosts with the following command:

{% highlight bash %}
docker-compose scale web=3
{% endhighlight %}

Now refreshing your browser will result in responses from three different hosts.You can scale the application down to two hosts with:

{% highlight bash %}
docker-compose scale web=2
{% endhighlight %}

The eeacms/haproxy container has lots of configuration options, why not [take a look](https://hub.docker.com/r/eeacms/haproxy/).

My colleague [Ahmet](https://twitter.com/ahmetalpbalkan) recommended I also look at [Interlock](https://github.com/Evlos/interlock) - I thought I'd drop a note here to remind me (and you).  
