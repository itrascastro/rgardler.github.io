---
layout: post
title: Experiments With Development Using Docker
tags: [devops, devtest, containers, docker]
---

I've been working with Docker for quite some time at Microsoft. A
recent change in job function has seen me get even more involved. I
have therefore started a GitHub project to experiment with using
Docker in a Dev/Test/Deploy scenario.

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

## Local Development ##

Development is undertaken on either a local client or a remote
machine.

## Staging Servers ##

## Load Testing ##

I wanted to build a simple load testing facility so I created a third container