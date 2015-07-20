---
layout: post
title: Creating a Private Docker Registry on Azure
tags: [docker, azure]
---

It's easy to creat a private Docker registry on Azure, here's how.

## Docker Host in Azure

We will be using a Docker container to provide our registry. Therefore
we need a Docker Host on azure. There are a number of ways you can
create such a host if you don't already have one:

FIXME: write a post about using the portal
FIXME: write a post on creating a host using ARM - http://azure.microsoft.com/documentation/templates/docker-simple-on-ubuntu/
FIXME: write a post on creating a host with docker-machine

## Storage Accounts and Keys

You will need a storage account and the key associated with that
account.

FIXME: write a post about installing the CLI
FIXME: write a post about managing storage accounts with the CLI

## Create the Registry

Since there is an official container that provides the registry all we
need to do is start that container on our host.

{% highlight bash %}
docker run -d -p 5000:5000 \
     -e REGISTRY_STORAGE=azure \
     -e REGISTRY_STORAGE_AZURE_ACCOUNTNAME="<storage-account>" \
     -e REGISTRY_STORAGE_AZURE_ACCOUNTKEY="<storage-key>" \
     -e REGISTRY_STORAGE_AZURE_CONTAINER="registry" \
     --name=registry \
     registry:2
{% endhighlight %}

## Securing the registry - http://docs.docker.com/registry/configuration/

## Use the registry

Now we have a registry available lets publish a container to it.

FIXME: command to push a contianer to the registry

## Further Reading

The official [Docker docs](http://docs.docker.com/registry/) are the
best place to learn more about Docker Registries.