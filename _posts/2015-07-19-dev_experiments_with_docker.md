---
layout: post
title: Experiments With Development Using Docker
tags: [devops, devtest, container, docker]
---

I've been working with Docker for quite some time at Microsoft. A
recent change in job function has seen me get even more involved. I
have therefore started a GitHub project to experiment with using
[Docker in a Dev/Test/Deploy
scenario](https://github.com/rgardler/AzureDevTestDeploy).

This post is the first of (probably) many which describe my
experiments, the succeses and the failures. I look forward to your
feedback as you you seek to help me correct some of my inevitable
mistakes.

## The Application ##

The [application](https://github.com/rgardler/AzureDevTestDeploy) is a
really simple one, at least in this first instance. It's an artifical
application to which I'll add random functionality to test new
ideas. Today it's just a hello world application that consists of two
containers:

  * [Java REST API](https://github.com/rgardler/AzureDevTestDeploy/tree/master/java) - simply returns a hello world message whenever queried
  * [PHP web application](https://github.com/rgardler/AzureDevTestDeploy/tree/master/web) - provides a web page which contians the response from the REST API

## Current Status ##

The application works and can be deployed to both a development and
staging environment (workstation, on-premise or public cloud). I've
scripted much of the configuration at this point, of course there are
better configuration management tools, but you have to start
somewhere.

There is currently no unit testing but I have provided a load tester.

### Environment setup

Scripts are available to create the necessary Docker hosts and to
build and deploy the containers to those hosts.

### Local Development

Development is undertaken on either a local client or a remote
machine. It's easier, however, to use a local machine as there is
minimal delay when testing a change.

### Staging Servers

I wanted to demonstrate how docker gives portability from the
development environment to the staging environment (and eventually
production). So I am testing using the public cloud. I am focusing on
Microsoft Azure, but it should work on any other cloud (patches to
prove this are welcome).

### Load Testing

I wanted to build a simple [load
testing](https://github.com/rgardler/AzureDevTestDeploy/tree/master/loadTest)
facility so I created a third container which does just that.

## ToDo list

I plan to gradually iterate on this application development and
testing enviornment as I experiment with different approaches. A few
of the things I want to try (in no particular order):

  * Unit testing
  * Integration testing
  * Automated staging builds
  * Faster development iteration model (e.g. in place editing and rebuilding of applications on dev containers)
  * Persistent data
  * Load balanced application
  * Deployment across multiple hosts

