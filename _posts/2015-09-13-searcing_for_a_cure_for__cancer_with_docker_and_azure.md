---
layout: post
title: Searching for a Cure for Cancer with Docker and Azure
tags: [azure, docker, container]
---

The Folding@Home project allows me to use idle capacity on my Docker hosts to help search for a cure for Cancer (and other diseases like Alzheimers and Parkinson). Here's how you can do it too. 

The short version is install Docker and run:

{% highlight bash %}
docker run -d rgardler/fah
{% endhighlight %}

# A Docker Container to Help Develop Drugs and Therapies

Since I typically have Docker hosts running on Azure at all times, ready for testing some new work or perhaps delivering an impromptu demo, I wanted to find a way to make use of those otherwise idle resources. This led me to the [Folding@Home](http://folding.stanford.edu/) project at Stanford.

I have no real understadning of what this does other than it "folds proteins". Apparently proteins "help your body break down food into energy, regulate your moods, and fight disease." In order to perform these functions they first "assemble themselves", which is known as folding. When this folding goes wrong it can cause "serious health consequences, including many well known diseases, such as Alzheimer's, Mad Cow (BSE), CJD, ALS, AIDS, Huntington's, Parkinson's disease, and many cancers."

The Folding@Home project simulates protein folding in an attempt to "better understand protein misfolding" so that "we can design drugs and therapies to combat these illnesses".

Sounds like this would be a good use of all those idle compute resources. I downloaded it to my laptop and watched as my spare cycles were used to fold proteins. Then I remembered the resources I have in the cloud, not on my desk. So I built a Docker container.

You can find the container in the Docker Hub as [rgardler/fah](https://hub.docker.com/r/rgardler/fah/) or on [GitHub](https://github.com/rgardler/docker-demos/tree/master/docker-folding).

# Using my Idle Time to Research Drugs and Therapies

Whenver I run a demo or start some dev work I SSH into my dev box and run a prepare.sh script. This script ensures that any preparation needed for my demo is done, such as pulling images, configuring TMux etc. One of the tasks it undertakes is to stop any running containers on the demo machine.

This means I can start my Folding@Home container when I finish a task and logout safe in the knowledge that it won't get in my way when I return. My prepare script will simply stop the container (the Folding@Home project is designed to cope with work units that are not completed).

What I would like to do (and I would love your help with this) is create a script that will detect when I'm not logged into the machine and fire up an instance of the Folding@Home container. In the meantime I just have to remember to type the following before exiting:

{% highlight bash %}
docker run -d rgardler/fah
{% endhighlight %}
