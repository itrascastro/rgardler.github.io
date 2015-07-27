---
layout: post
title: Create Account on Azure Chef Server
tags: [chef, azure]
---

It's easy to start a Chef Server on Azure but creating the initial
user account and geting the required validation key to use it takes a
little work. Here's my minimal set of instructions for how to do it.

# Installing a Chef Server on Azure

FIXME: It's in the marketplace

# Configuring a Chef Servre on Azure

SSH into the server:

{% highlight bash %}
  ssh rgardler@rgchefservertr.cloudapp.net
{% endhighlight %}

Conveniently the login message tells you the command you need to run. It is:

{% highlight bash %}
  sudo chef-setup -u <username> -p <password>
{% endhighlight %}

This command creates the user and generates an RSA private key in
<username>.pem. This file is used to authenticate against the
server. But before we can do that we need to set up an organization on
the server.

Visit your Chef server in the browser, log in using the credentials
you used above and select "Create Organization". Provide a full name
and a short name for the Organization. The full name is used for us
humans, the short name for the computer (e.g. in URLs).

On the resulting screen you will see an option to "Download Starter
Kit", selec this option. You will be warned that user and organization
keys will be reset, that's OK since we haven't used any keys yet. A
chef-starter.zip file will be downloaded.

Unzip the chef-starter.zip file into your home directory. This will
provide a new folder called chef-repo. This directory includes a
number of useful things including your user and organizaton .pem files
(find them in the .chef folder).

# Next Steps

You are now ready to start using Knife or other tools to manage your
Chef server. Such as [Azure Resource Manager Quickstart
Templates](http://azure.microsoft.com/en-us/documentation/templates/).