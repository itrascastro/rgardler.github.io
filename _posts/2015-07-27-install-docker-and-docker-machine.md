---
layout: post
title: Install Docker and Docker Machine
tags: [docker, devtest]
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
curl -L -k https://github.com/docker/machine/releases/download/v0.4.1/docker-machine_windows-amd64.exe > /bin/docker-machine
{% endhighlight %}

NOTE 1: The '-k' switch in the above command causes curl to operate in
insecure mode. If you are the cautious type (and you should be) then
you will want to download the file using a browser and copy it
manually into "C:\Program Files (x86)\Git\bin" so that your browser
verifies the host serving this file.

NOTE 2: You might want to check whether v0.4.1 is the latest version by
visiting the [Docker Machine releases
page](https://github.com/docker/machine/releases)

While you are at it you will probably want to install Docker itself
since a Docker host without the command line to manage it is not so
useful. To install Docker as well run the following command:

{% highlight bash %}
curl -L https://get.docker.com/builds/Windows/x86_64/docker-latest.exe > /bin/docker
{% endhighlight %}

# Install Docker Machine on Linux

Since Linux already includes the dependencies you need to run Docker
Machine you can simply go ahead and run the following commands:

{% highlight bash %}
sudo wget https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/local/bin/docker
sudo chmod +x /usr/local/bin/docker
{% endhighlight %}

NOTE: You might want to check whether v0.3.1 is the latest version by visiting the [Docker Machine releases page](https://github.com/docker/machine/releases)

As above, you will likely want to install the Docker client as well so
that you can mange the Docker host you create.

{% highlight bash %}
sudo wget https://github.com/docker/machine/releases/download/v0.3.1/docker-machine_linux-amd64 -O /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine
{% endhighlight %}

# Verify the Docker Machine Install

You should now be able to run "docker-machine --version" and get a
response. If you installed Docker then you can also verify it has
installed correctly with "docker --version".

# Next Steps

Now you have Docker and Docker Machine installed you could start using them to [manage containers and hosts on Azure]({% post_url 2015-07-22-using-docker-machine-on-azure %}), for example.
