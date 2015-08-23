---
layout: post
title: Docker Container Service Discovery Using Serf
tags: [docker, serf, orchestration]
---

Creating a microservice based Docker application can be chllenging if
we don't know where our containers will be running. Serf provides a
lightweight mechanism for service discovery. Here's how to get started
with Docker and Serf.

# Experimenting With Serf

[Serf](https://serfdom.io/) is a decentralized solution for cluster
membership, failure detection and orchestration. In this simple
example we will be using it for discovery in a cluster membership.

## Defining a Docker Container With Serf Agent Installed

To start off let's build a Docker container with a Serf agent on it,
we'll need a Dockerfile, a couple of simple scripts and a
configurtation file:

### Dockerfile

{% highlight bash %}
FROM ubuntu:14.04.2

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q
RUN apt-get install -qqy build-essential git supervisor unzip

ADD https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip serf.zip
RUN unzip serf.zip
RUN rm serf.zip
RUN mv serf /usr/bin/

ADD /start-serf.sh /start-serf.sh
ADD /run.sh /run.sh
ADD /supervisord-serf.conf /etc/supervisor/conf.d/serf.conf
RUN chmod 755 /*.sh

EXPOSE 7946 7373
CMD ["exec supervisord -n"]
{% endhighlight %}

There are two scripts needed, and a configuration file for supervisor,
these are as follows.

### run.sh

{% highlight bash %}
#!/bin/bash 
exec supervisord -n -c /etc/supervisor/serf.conf 
{% endhighlight %}

### start-serf.sh

{% highlight bash %}
#!/bin/bash
exec serf agent -tag role=serf-agent 
{% endhighlight %}

### supervisord-serf.conf

{% highlight bash %}
[program:serf] 
command=/start-serf.sh 
numprocs=1 
autostart=true 
autorestart=true 
{% highlight %}

## Build the container image

{% highlight bash %}
docker build -t serf .
{% endhighlight %}

## Run the a container

{% highlight bash %}
docker run -d --name serf_example -p 7946 -p 7373 serf
{% endhighlight %}



### Credits

The inspriation and most of the hard work for this post comes from [Lucas
Carlson](https://labs.ctl.io/decentralizing-docker-how-to-use-serf-with-docker/). 