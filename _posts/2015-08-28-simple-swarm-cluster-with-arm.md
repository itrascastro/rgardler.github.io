---
layout: post
title: Create a Simple Swarm Cluster on Azure with ARM
tags: [swarm, docker, azure, container]
---

Azure Resource Manager Templates provide a way to manage Azure
resources in code. In this post we'll look at how to create a Docker
Swarm cluster using an ARM template. This has some advantages over the
[docker-machine commands examined]({% post_url 2015-08-23-getting_started_with_docker_swarm %}), creating each
resource within a single resource group which makes it easier to
manage going forwards as well as providing more control over the
resources created.

# Introduction to ARM QuickStart Templates

Azure Resource Manager (ARM) QuickStart Templates are open source
templates that are designed to help get you started with ARM. The idea
is that they provide examples of common tasks. They probably don't do
exactly what you need but they do provide a good starting point.

Using them couldn't be simpler, find one you like the look of on the
[GitHub
repository](https://github.com/Azure/azure-quickstart-templates) and
then click the Deploy Button that appears on most template pages (some
templates are not complete examples and therefore do not have a deploy
button attached).

It is outside the scope of this post to cover ARM Templates in
detail. Our goal here is to get a Docker Swarm cluster up and running
as quickly as possible. Fortunately, the QuickStarts project provides
a [simple Swarm
template](https://github.com/Azure/azure-quickstart-templates/tree/master/docker-simple-on-ubuntu)
to get us started.

# Limitations of the Simple Template

This template is designed to allow you to test things quickly. It is
not designed to provide a production ready swarm cluster. One of the
primary reasons for this is that it does not set up secure connections
with the Swarm Master. However, it does mean that we have minimal
overhead in getting going.

If you prefer you can use the more complete [Swarm example
template](https://github.com/Azure/azure-quickstart-templates/tree/master/docker-swarm-cluster).

# Preparation

## Install Docker

You will need Docker installed as well as a Docker host on which you
can run the Swarm container. It is possible to run Swarm as a separate
application but we find it is very convenient to run it as a
container. My earlier post [Using Docker Machine on Azure]({% post_url 2015-07-22-using-docker-machine-on-azure %}) will get you started
if you don't know how.

## Creating a Swarm Registry

A Swarm cluster needs a registry so that it knows which Docker hosts
belong to that swarm cluster. We covered this in the previous post on
using docker-machine to create a swarm. See "Create the Swarm Cluster"
in [Getting Started with Docker Swarm]({% post_url 2015-08-23-getting_started_with_docker_swarm %}).

# Deploying the Swarm Template

Deploying the Swarm Template couldn't be simpler. Visit the [simple
Swarm
template](https://github.com/Azure/azure-quickstart-templates/tree/master/docker-simple-on-ubuntu)
GitHub page and click the deploy button. This will open up the Azure preview portal where you will need to provide a few parameters, as follows:

Storage Account Name: this is the name of the storage account that
will be created for your hosts. Your hosts disks will be placed in
this storage account.

Admin Username: This is the admin username for the Master VM.

Admin Password: The password for the admin user on the Master VM.

DNS name: This is a world unique prefix for the DNS name for the
Master VM. The complete DNS will be
THIS_PARAMTERmaster.westus.cloudapp.net.

Ubuntu Version: The VMs we are creating is based on Ubuntu. This
paramater allows us to select a specific version.

Slave Count: The number of nodes you want in your Swarm.

Swarm Cluster ID: the id retrieved in the previous step.

Note that you can also run the template from the Azure CLI or from
Powershell, see the [documentation on Microsoft.com](http://azure.microsoft.com/en-us/documentation/templates/docker-swarm-cluster-simple/).

# Using Your Swarm

Now that you have a Swarm you need to configure Docker to use it. To
do this you just need to set a couple of environmetn variables:

{% highlight bash %}
export DOCKER_TLS_VERIFY=
export DOCKER_HOST="tcp://DNS_NAMEmaster.westus.cloudapp.azure.com:2376"
{% endhighlight %}

Remember to replace DNS_NAME with the value of the DNS parameter you
provided when deploying the template. Once you have run this command
you work with the Swarm cluster just as you would any other Docker
machine. Swarm will attempt to balance the containers across the three
hosts.






