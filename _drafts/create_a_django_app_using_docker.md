---
layout: post
title: Create a Django App Using Docker
tags: [docker, container, django]
---

[Django](https://www.djangoproject.com/) "makes it easier to build
better Web apps more quickly and with less code." Creating a
Dockerized Django application is easy. Here's the approch I use.

# Scenario

I have a an application I use to play around with new tecnologies like
this. It's not intended to be a real application. It's more of a bunch
of hello world applications put together to experiment with using
Docker in a multi-language, multi service Dev/Test/Deploy scenario. 

To this end I'm going to add a Django hello world application. The
goal, for this post, is to create a Django developer environment.

# Pre-requisites

Since we'll be working with Docker you will need Docker installed
(well duh!). However, you will not actually need Python or Django
installed on your client machine since we'll rely on containers for
that.

You will probably also want to install Docker Machine as this tool
makes it easier to create Docker hosts for development.

I wrote an earlier post on installing
[Docker and Docker Machine]({% post_url 2015-07-27-install-docker-and-docker-machine %}) so I won't
repeat things here.

# Creating your Django Dev Container



FIXME: bring over content from the Comdev_tools app readme