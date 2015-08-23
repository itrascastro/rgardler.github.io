---
layout: post
title: Getting Started With Docker Swarm on Azure
tags: [swarm, docker, azure, containers]
---

Docker Swarm allows you to manage a cluster of Docker Hosts as if they
were a single machine. All interactions with a Swarm cluster are
carried out through the Docker API, consequently, any tool that can
manage a Docker host machine can manage a Docker Swarm cluster. Here's
a quick "getting started" guide for Docker Swarm.

# The Objective

We want to create a swarm cluster of two machines and then deploy
multiple containers to that cluster. We will not do anything to
control where the containers run, we'll just leave that up to the
default scheduler in Swarm.

# Preparation

I'll be using Docker Machine to create the Swarm and then using the
Docker command line to deploy containers on that Swarm. I'll also be
using Microsoft Azure as the cloud provider for my swarm, however, one
of the key advantages of Docker Machine is that the commands are very
nearly identical for working on your local machine or another cloud
provider.

To follow this guide you need a basic familiarality with Docker
Machine and the Docker CLI. My guide to getting started with [Docker
Machine]({% post_url 2015-07-22-using-docker-machine-on-azure %}) will
explain what you need to follow along here.

You could install Swarm on your client machine in order to create and
manage your swarm cluster. However, there is a Docker container
pre-configured with Swarm so I'm going to use that. This means we need
to first ensure we have Docker Swarm available.

## Creating a Swarm Client

First we need a Docker host to put our swarm container on. I have a
machine called "rgdev" that I use for this purpose, it is created with
the following command:

{% highlight bash %}
docker-machine create -d azure --azure-location="Central US" --azure-subscription-id="$AZURE_SUBSCRIPTION_ID" --azure-subscription-cert="mycert.pem" rgdockerdev
{% endhighlight %}

Since I'm are using Azure as my hosting platform for all containers my
commands require some Azure specific parameters. If you are using
another cloud provider you will need a different set of parameters,
see the documentation for your provider. If you are using your local
machine then you will use "-d virtualbox" or "-d hyper-v" in place of
"-d azure" and you can leave out all parameters that begin
"--azure". For example:

{% highlight bash %}
docker-machine create -d hyper-v rgdockerdev
{% endhighlight %}

Now you need to ensure that the Swarm container is available on this
host.

{% highlight bash %}
eval "$(docker-machine env rgdockerdev)"
docker pull swarm
{% endhighlight %}

Finally, we can ensure the swarm container is working:

{% highlight bash %}
docker run swarm
{% endhighlight %}

# Create Swarm Cluster

A Swarm cluster needs a registry so that it knows which Docker hosts
belong to that cluster. There are a number of registries you can use,
but for simplicity I'll use the Docker Hub which requires minimal
setup.

On your dev machine run the command below. If you are following along
then you have already configured docker to work with the dev machine
using 'eval "$(docker-machine env rgdockerdev)" or similar. If you are
not following along you will need to ensure you are working with the
correct docker host before running this command:

{% highlight bash %}
sid=$(docker run swarm create)
{% endhighlight %}

This command creates a Swarm cluster and returns a Swarm ID, which we
store in $sid for later use.

## Create the Swarm Master

A Swarm cluster consists of a master and a set of nodes. To create the
master run the following command:

{% highlight bash %}
docker-machine create -d azure --azure-location="$AZURE_LOCATION" --azure-subscription-id="$AZURE_SUBSCRIPTION_ID" --azure-subscription-cert="$AZURE_CERT_NAME" --swarm --swarm-master --swarm-discovery token://$sid  rgswarm-master
{% endhighlight %}

Remember, if you are using your local machine just replace "-d azure"
with "-d hyper-v" or "-d virtualbox" and remove the parameters
prefixed with "--azure".

### Open the Swarm Port if Using A Cloud Provider

Unfortunately, at the time of writing, docker-machine (0.4.1) does not
open the Swarm port on the Docker Host on Azure. You will need to do
this manually. I opened an
[issue](https://github.com/docker/machine/issues/1748) on this topic,
check to see if it has been resolved in your version of
docker-machine.

If this issue hasn't been resolved in the version of Docker Machine
you are using then you will need to open the port 3376 using the Azure
management portal or the Azure CLI.

## Add two nodes to the cluster

Now we have a master we need some nodes, we'll add two here but you
can add more simply by repeating the below 'docker-machine create...'
command, ensuring each node gets a unique name:

{% highlight bash %}
docker-machine create -d azure --azure-location="$AZURE_LOCATION" --azure-subscription-id="$AZURE_SUBSCRIPTION_ID" --azure-subscription-cert="$AZURE_CERT_NAME" --swarm --swarm-discovery token://$sid rgswarm-node-01
docker-machine create -d azure --azure-location="$AZURE_LOCATION" --azure-subscription-id="$AZURE_SUBSCRIPTION_ID" --azure-subscription-cert="$AZURE_CERT_NAME" --swarm --swarm-discovery token://$sid rgswarm-node-02
{% endhighlight %}

# Deploy containers to the cluster

Now all that remains is to deploy some containers on our
cluster. We'll fire up some busybox containers to illustrate how this
works.

We need to point our Docker CLI at the Swarm master:

{% highlight bash %}
eval "$(docker-machine env --swarm rgswarm-master)"
{% endhighlight %}

Note the "--swarm" flag here, it tells Docker to connect via the Swarm
port rather than the standard Docker one. Without this switch you will
simply create the containers on the host your master is running on.

Now lets deploy our first container:

{% highlight bash %}
docker run -itd --name box0 busybox
{% endhighlight %}

Because we are using Swarm we do not know which of the two nodes
this has been created on. If we want to know we can find out by
looking at the running processes on the Swarm:

{% highlight bash %}
docker ps
{% endhighlight %}

Lets use a for loop to create some more containers:

{% highlight bash %}
for name in box1 box2 box3 box4 box5 box6;
 do docker run -itd --name $name busybox;
done
{% endhighlight %}

Now convince yourself that you are using Swarm to schedule where these
are deployed:

{% highlight bash %}
docker ps
{% endhighlight %}

You should see a fairly even distribution of the containers across
your two nodes.

# Next Steps

This is Swarm in its most basic form. There are many interesting
things you can do with Swarm, such as:

  * Influence how Swarm decides which hosts to deploy containers on
  * Deploy complete applications using Docker Compose
  * Plug in a different scheduler, e.g. Apache Mesos
  * Use a different registry, e.g. Consul

