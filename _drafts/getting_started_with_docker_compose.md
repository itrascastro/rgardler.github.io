---
layout: post
title: Getting Started with Docker Compose
tags: [compose, docker, container, orchestration]
---

Docker Compose provides a way to describe a containerized application in code. It can then be used to quickly startup and scale the application. Here how to get started.

# Prerequisites

It is assumed that you already know a little about Docker and have a Docker Host available.

# Install

Lookup the latest release version number on the Docker Compose releases page](https://github.com/docker/compose/releases)

Use the following commands, ensuring you replace 1.4.0 with the current release number (if necessary).

{% highlight bash %}
curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
{% endhighlight %}

# A Sample Application

For illustrative purposes we'll keep it simple. Our
[application](https://github.com/rgardler/AzureDevTestDeploy) is a PHP webapp that makes a REST call to a Java REST API. We will use HA Proxy to load balance the PHP application.

The resulting compose file looks like this:

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





# Resources

http://docs.docker.com/compose/
