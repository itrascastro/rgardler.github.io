---
layout: post
title: Create a Django App Using Docker
tags: [docker, container, django]
---

Creating a Dockerized Django application is easy. Here's the approch I
use.

# Pre-requisites

Since we'll be working with Docker you will need Docker installed
(well duh!). However, you want actually need Python or Django
installed on your client machine since we'll rely on containers for
that.

You will probably also want to install Docker Machine as this tool
makes it easier to create Docker hosts for development.

I wrote an earlier post on installing [Docker and Docker Machine]({% post_url 2015-07-27-install-docker-and-docker-machine %}) so I won't repeat things here.

# Creating your Django Application

FIXME: bring over content from the Comdev_tools app readme