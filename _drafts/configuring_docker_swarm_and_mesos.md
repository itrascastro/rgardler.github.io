---
layout: post
title: Configuring Docker, Swarm and Mesos
tags: [docker, mesos, swarm, container]
---

Docker is great for managing single containers on single hosts. Swarm
provides a way to treat multiple hosts as a single host, making
multi-host management easier using standard Docker toolign. Apache
Mesos provides powerful orchestration to ensure optimal and efficient
use of the reources available on those hosts. In this post I look at
how to set up a simple Docker cluster using Swarm and Mesos.

# The Goal

By the end of this post we will have the following setip:

  1. A master VM with:
    * Docker
    * Docker Swarm (running as a container)
    * Apache Mesos Master
    * Apache Zookeeper
  2. One or more Docker hosts VM's with:
    * Docker
    * Apache Mesos Agent (formally called Slave)

You will be able to deploy containerized applications to this cluster
using any Docker API compliant software. We'll demonstrate it working
using the Docker CLI.

This will not be a production ready cluster. Our goal here is not to
be perfect, our goal is to get the basics in place. The end result
will be good for use in a development environment but should not be
used in produciton. There are two main reasons for this, firstly we
will only have a single Mesos master with a single Zookeeper node, in
production you will want at least three of each. The second reason you
don't want to use this in production is that we are using an insecure
connection to the Swarm.

In this tutorial our virtual machines are running Ubuntu 14.04 but the
methods used should be easily translatable to any other Linux
operating system.

# Build and Configure the Master

On your master you will need:

**[Docker Swarm](https://docs.docker.com/swarm/)**: the scheduler for
deploying and managing Docker based applications.
  
**[Apache Mesos](http://mesos.apache.org/) master**: provides fine
grained control of the resources in the cluster.

**[Apache Zookeeper](http://zookeeper.apache.org/)**: To provide fault
tolerance in the Mesos cluster (note in this single node configuration
there is no real faulr tolerance)

We will build a script that can be run against a vanilla Ubuntu 14.04
VM to configure it approriately. In the next couple of sections I'll
work through the primary sections of this script. You should add each
of the sections into a single script for ease of execution.

## Script Parameters

Our script will accept two parameters that will be used later, both of
these parameters are required. For simplicity I'm excluding the error
checking here but you might want to provide it.

{% highlight bash %}
# The IP or DNS name for the master
masterIP=$1
# The Cluster Name should be passed in as the second parameter
clusterName=$2
{% endhighlight %}

## Install and Configure Mesos and Zookeeper

Apache Mesos acts as our orchestrator. Since it is an Apache project
there are only source files available from the originating project,
however [Mesosphere](https://mesosphere.com/), as part of their DCOS
(Datacenter Operating System) product provide packages for a number of
popular distributions. We'll use those packages for convenience.

{% highlight bash %}
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main" | \
  sudo tee /etc/apt/sources.list.d/mesosphere.list
sudo apt-get -y update

sudo apt-get -y install mesos
{% endhighlight %}

Once installed we need to configure Mesos. Here we will not use the
Master node as an Agent (nee Slave), although in a small cluster it
would make sense to do so since the load on the master server will be
minimal.

{% highlight bash %}
# Disable mesos-slave on this node
sudo service mesos-slave stop
echo manual | sudo tee /etc/init/mesos-slave.override

# Set the master Zookeeper
echo zk://$masterIP:2181/mesos | sudo tee /etc/mesos/zk

# Specify a human readable name for the Cluster
echo $clusterName | sudo tee /etc/mesos-master/cluster

# each Zookeeper needs to know its position in the quorum
echo 1 | sudo tee /etc/zookeeper/conf/myid
{% endhighlight %}

## Configuring Swarm

We could download the source for Docker Swarm and build it
locally. However, for convenience we are going to run it from a
container available in Docker Hub. This requires us to install Docker
which has the added advantage that we could use the master as an agent
too. In a small cluster this would be fine as the load on the master
will be minimal.

{% highlight bash %}
wget -qO- https://get.docker.com | sh
{% endhighlight %}

Then we need to start the Swarm container:

{% highlight bash %}
# Run swarm manager container on port 2375 (no auth)
sudo docker run -d -e SWARM_MESOS_USER=root \
    --restart=always 
    -p 2375:2375 -p 3375:3375 swarm manage \
    -c mesos-experimental \
    --cluster-opt mesos.address=0.0.0.0 \
    --cluster-opt mesos.port=3375 $masterIP:5050
{% endhighlight %}

Take special notice of the '-e SWARM_MESOS_USER=root' parameter. I
didn't find this documented anywhere. It was only with the help of
[Timothy Chen](https://github.com/tnachen) of Mesosphere that I
discovered the need for this (thanks Tim!). The symptoms were that
while Docker could see the cluster any attempt to run a container on
it resulted in "Error response from daemon: Abnormal executor
termination". If you are interested you can see how Tim helped [debug
this](https://github.com/docker/swarm/issues/1177).

## Start the Services

Now everything is installed and configured we need to restart the
Mesos and Zookeeper services.

{% highlight bash %}
sudo service zookeeper restart
sudo service mesos-master restart
{% endhighlight %}

And with that our master node is complete.

# Build and Configure the Agent (nee Slave)

On your agent nodes we will need:

**[Docker](https://docs.docker.com)**: for running your containers
  
**[Apache Mesos](http://mesos.apache.org/) agent**: works with the
  Mesos master to ensure workloads are correctly orchestrated.

As with the master we will build a script that can be run against a
vanilla Ubuntu 14.04 VM to configure it approriately. In the next
couple of sections I'll work through the primary sections of this
script. You should add each of the sections into a single script for
ease of execution.

## Script Parameters

Our script will accept a single parameter that will be used later. For
simplicity I'm excluding the error checking here but you might want to
provide it.

{% highlight bash %}
# The IP or DNS name for the master
masterIP=$1
{% endhighlight %}

## Install and Configure Mesos

First of all we need to install Apache Mesos. This is done using the
same code as for the master (see above). Once installed we need to
configure it as an agent and ensure that it registers itself via
Zookeeper running on the master.

{% highlight bash %}
# Stop and disable mesos-master
sudo service mesos-master stop
echo manual | sudo tee /etc/init/mesos-master.override

# Add docker containerizer
echo "docker,mesos" | sudo tee /etc/mesos-slave/containerizers

# Configure zk
echo "zk://$masterIP:2181/mesos" | sudo tee /etc/mesos/zk

# Disable and stop zookeeper
sudo service zookeeper stop
echo manual | sudo tee /etc/init/zookeeper.override
{% endhighlight %}

## Install and Configure Docker

{% highlight bash %}
# Start Docker and listen on :2375 (no auth, but in vnet)
echo 'DOCKER_OPTS="-H unix:// -H 0.0.0.0:2375"' | sudo tee /etc/default/docker
{% endhighlight %}

## Start the Services

Now everything is installed and configured we need to restart the Docker
and Mesos services.

{% highlight bash %}
sudo service docker restart
sudo service mesos-slave restart
{% endhighlight %}

And with that our agent node is complete.

# Building and Using a Cluster

To build your cluster you simply need to create Ubuntu VM's and run
the appropriate script on them. For our example case you will need one
master and any number of agents. On the master ensure port 2375 is
open for Swarm and port 5050 for the Mesos.

Once you have your cluster up and running it's time to start working
with it. To do so all you need something that is capable of running
Docker containers. In the examples below we'll use the [Docker
CLI](http://docs.docker.com/installation/ubuntulinux/).

First you need to configure the DOCKER_HOST to be used. You also want
to ensure that no TLS verification is attempted (remember this is an
insecure cluster).

{% highlight bash %}
export DOCKER_HOST:tcp://yourmasternode:2375
export DOCKER_TLS_VERIFY=
{% endhighlight %}

Strinctly speaking the DOCKER_TLS_VERIFY is probably not needed. It is
empty by default and will only have a value if you previously set
it. Some Docker tools set it automatically so I always find it is
safest to ensure it is empty.

Now you should be able to view the status of your cluster:

{% highlight bash %}
docker info
{% endhighlight %}

Which will provide an output something like this:

{% highlight bash %}
Containers: 0                                                
Images: 0                                                    
Role: primary                                                
Strategy: spread                                             
Filters: affinity, health, constraint, port, dependency      
Offers: 3                                                    
  Offer: 20150830-195526-100663306-5050-36448-O13            
   - cpus: 1                                                 
   - mem: 2.361 GiB                                          
   - disk: 23.8 GiB                                          
   - ports: 31000-32000                                      
  Offer: 20150830-195526-100663306-5050-36448-O14            
   - cpus: 1                                                 
   - mem: 2.361 GiB                                          
   - disk: 23.8 GiB                                          
   - ports: 31000-32000                                      
  Offer: 20150830-195526-100663306-5050-36448-O15            
   - cpus: 1                                                 
   - mem: 2.361 GiB                                          
   - disk: 23.8 GiB                                          
   - ports: 31000-32000                                      
CPUs: 3                                                      
Total Memory: 7.084 GiB                                      
Name: 2d533d2c4451
{% endhighlight %}

Of course there are no containers running on this cluster at present
(you can confirm this with 'docker ps'). So lets run some:

{% highlight bash %}
for name in first second third fourth fifth; docker run -m 256m -name $name busybox sleep 999999; done
{% endhighlight %}

And see how they were distributed across the cluster:

{% highlight bash %}
docker ps
{% endhighlight %}

In the output notice how the name of the containers have been prefixed
with the name of the agent they are running on.

# Next steps

  * Deploy a real application to the cluster
  * Make the cluster secure
  * Provide multiple master nodes for more resilience
  * Build a cluster in the cloud (given where I work that will be in Azure)

