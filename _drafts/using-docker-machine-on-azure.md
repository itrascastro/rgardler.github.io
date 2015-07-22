---
layout: post
title: Using Docker Machine to create a Docker Host on Azure
tags: [docker, azure, devtest]
---

Docker Machine lets you create Docker hosts on your computer, on cloud
providers, and inside your own data center. It creates servers,
installs Docker on them, then configures the Docker client to talk to
them. Here's how to use it to create Docker Hosts on Azure.

# Install Docker Machine (Windows)

If you are not using a Windows client skip forward to the next section
(Install Docker Machine (Linux).

Docker Machine is just a binary, so instalation is as simple as
downloading it and placing it in your path. If you are using a Windows
client machine then I recommend first installing [Git for
Windows](http://msysgit.github.io/). The reason for this is that this
package includes some libraries that Docker Machine relies on. It's a
convenient way of getting those libraries in one easy install.

Once Git for Windows is installed you will have a Git Bash shell
available. All the commands below should be run in a Bash shell, to
open one hit the Windows key and type "bash", you should see a "Git
Bash" application - run it.

In the resulting shell execute the following command:

{% highlight bash %}
curl -L -k https://github.com/docker/machine/releases/download/v0.3.1/docker-machine_windows-amd64.exe > /bin/docker-machine
{% endhiglight %}

NOTE 1: The '-k' switch in the above command causes curl to operate in
insecure mode. If you are the cautious type (and you should be) then
you will want to download the file using a browser and copy it
manually into "C:\Program Files (x86)\Git\bin" so that your browser
verifies the host serving this file.

NOTE 2: You might want to check whether v0.3.1 is the latest version by
visiting the [Docker Machine releases
page](https://github.com/docker/machine/releases)

While you are at it you will probably want to install Docker itself
since a Docker host without the command line to manage it is not so
useful. To install Docker as well run the following command:

{% highlight bash %}
curl -L https://get.docker.com/builds/Windows/x86_64/docker-latest.exe > /bin/docker
{% endhiglight %}

# Install Docker Machine on Linux

Since Linux already includes the dependencies you need to run Docker
Machine you can simply go ahead and run the following commands:

{% highlight bash %}
sudo wget https://github.com/docker/machine/releases/download/v0.3.1/docker-machine_linux-amd64 -O /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine
{% endhighlight %}

NOTE: You might want to check whether v0.3.1 is the latest version by visiting the [Docker Machine releases page](https://github.com/docker/machine/releases)

As above, you will likely want to install the Docker client as well so
that you can mange the Docker host you create.

{% highlight bash %}
sudo wget https://github.com/docker/machine/releases/download/v0.3.1/docker-machine_linux-amd64 -O /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine
sudo wget https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/local/bin/docker
sudo chmod +x /usr/local/bin/docker
{% endhighlight %}

# Verify the Docker Machine install

You should now be able to run "docker-machine --version" and get a
response. If you installed Docker then you can also verify it has
installed correctly with "docker --version".

# Create a Docker Machine on the client

If you have VirtualBox (on Linux or Windows) or Hyper-V (Windows only)
you can now start working with docker-machine. Whilst this post is
about working with Docker Machine on Azure it is worth taking a short
detour to see this in action.

To create a Docker Machine called 'dev' run the following command:

{% highlight bash %}
docker-machine create -d hyper-v dev
{% endhighlight %}

This will download the latest Boot2Docker image and create a virtual
machine using it. The VM will use the first virtual network switch
available (if there are none defined this command will fail). Once the
VM is started Docker Machine will configure your Docker client to
manage that virtual machine.

From this point forwards working with this machine is identical to
that described in the sections on Azure below (although you will use
the machine name dev in place of the azure machine name used below).

## If Things Go Wrong

If the creation of the VM fails for some reason you will want to
ensure all traces of it are removed before trying again. To do this
run the following command:

{% highlight bash %}
docker-machine rm -f dev
{% endhighlight %}

# Obtain an Azure Subscription

If you already have an Azure subscription you can skip to the next
section. If you have an MSDN subscription then you can activiate your
[included Azure
credits](http://azure.microsoft.com/pricing/member-offers/msdn-benefits-details/). Alternatively
you can start a [free
trial](http://www.windowsazure.com/en-us/pricing/free-trial/?WT.mc_id=AA4C1C935).

# Configure Docker Machine to use Your Azure Subscriuption

Docker Machine uses OpenSSL keys to authenticate against your Azure
subscription. You therefore need to generate these keys and upload the
approprate certificate to Azure.

Once you have an active subscription run the following commands in a
shell:

{% highlight bash %}
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
openssl pkcs12 -export -out mycert.pfx -in mycert.pem -name "My Certificate"
openssl x509 -inform pem -in mycert.pem -outform der -out mycert.cer
{% endhighlight %}

Now you need to go to the Azure portal
(https://manage.windowsazure.com). In the "Settings" section select
"Management Certificates" and upload mycert.cer.

While here grab your subscription ID from the portal and record it for
use in the next section.

# Create a Docker Host on Azure

To create a Docker Host on Azure you run the following command,
replacing $AZURE_SUBSCRIPTION_ID with the subscription ID you
retrieved in the previous section and $MACHINE_NAME with a world
unique name. This will be the DNS name of your machine and thus needs
to be world unique, I tend to use something like
"rgMachineDescriptorUID" (where 'rg' are my initials,
'MachineDescriptor' is a meaningful name and 'UID' is an optional
unique ID number).

{% highlight bash %}
docker-machine create -d azure --azure-location="Central US" --azure-subscription-id="$AZURE_SUBSCRIPTION_ID" --azure-subscription-cert="mycert.pem" $MACHINE_NAME
{% endhighlight %}

After a short while your VM will have been created on Azure. You will
be able to see it in the Azure Management Portal as well as manage it
with tools such as the Azure Cross Platform CLI. However, we are more
interested in using the docker tooling to work with it.

The following command will list all Docker Machines your current
client is aware of:

{% highlight bash %}
docker-machine ls
{% endhighlight %}

# Working with your Docker Host

To work with your Docker host you can use the Docker CLI tools (or any
other tools that conform to the standard Docker API). However, since
you may have multiple hosts available you must first tell the CLI
tools which host to work with. To do this run the following command
(being sure to replace $MACHINE_NAME with the name you used when
creating the host):

{% highlight bash %}
eval "$(docker-machine env $MACHINE_NAME)"
(% endhighlight %)

From this point forward you use the Docker CLI as you would on any
platform. For example to fire up a BusyBox container on your host and have it report information about itself you could run:

{% highlight bash %}
docker run busybox uname -a
{% endhighlight %}

# Next steps

At this point you should familiarize yourself with the Docker tools, perhaps through some ("hello world" containers](https://docs.docker.com/userguide/dockerizing/). Alternatively you could take a look at my [containerized demo application](https://github.com/rgardler/AzureDevTestDeploy) which provides a multi-container application complete with scripts for building and deploying it.

