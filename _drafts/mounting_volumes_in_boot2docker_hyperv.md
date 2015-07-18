---
layout: post
title: Mounting Volumes in Boot2Docker on Hyper-V
tags : [docker, container, hyper-v]
---

Docker is awesome for development. However, when sharing volumes with
Boot2Docker things don't quite behave as expected (i.e. it doesn't
work). Here's how to work around this on Windows.

## The Problem ##

Since containers are intended to be immutable this isn't really a
problem for production, but in development we want to be able to mount
our code in the container to enable a faster turnaround in the
development process, that is we need to edit files and see the results
immediately.

Unfortunately, Boot2Docker does not currently mount the Windows files
which means when you try to mount a voulme using the '--volume' (or
'-v') option you end up with an empty drive. 

## The Solution ##

I use this little script to mount my current directory on the
Boot2Docker guest. This only needs to be run once for each Docker host
you create.

{% highlight bash %}
# There is currently (5/31/2015) a bug in docker-machine/boot2docker that
# means shared folders do not work as expected. To work around this
# bug run the following script (after editing the last line) each time you 
# provsiion a hyper-v docker-machine.

read -p "What is the name of the Docker machine you want to configure?" DEV_MACHINE_NAME
echo
read -p "What is the username for your Windows user account?" USER_NAME
echo
read -s -p "What is the password for the user account '$USER_NAME'?" USER_PASSWORD
echo
read -p "What is the IP of your client machine?" CLIENT_IP
echo

echo
echo "Configuring $DEV_MACHINE_NAME"

docker-machine ssh $DEV_MACHINE_NAME wget http://distro.ibiblio.org/tinycorelinux/5.x/x86/tcz/cifs-utils.tcz
docker-machine ssh $DEV_MACHINE_NAME -- tce-load -i cifs-utils.tcz
docker-machine ssh $DEV_MACHINE_NAME mkdir project

CLIENT_DIR=`echo $PWD | cut -c 3-`
echo "Mounting //$CLIENT_IP$CLIENT_DIR as $PWD"
docker-machine ssh $DEV_MACHINE_NAME -- "sudo mount -t cifs //$CLIENT_IP$CLIENT_DIR $PWD -o user=$USER_NAME,password=$USER_PASSWORD"
{% endhighlight %}

Note that the folder you want to mount must be shared on Windows. Your Home directory is automatically shared, but if you are outside that directory you will need to share it.

Once you have run this you cn mount directories as normal, e.g. here's how I run my [Jekyll container]({{ BASE_PATRH }}/2015/07/18/docker-container-for-jekyll):

{% highlight bash %}
docker run --rm -v "/$PWD:/src" -p 4000:4000 -t jekyll grahamc/jekyll serve -H $CLIENT_IP --drafts --force_polling
{% endhighlight %}

Note the extra '/' before '$PWD' in this command. This isn't needed on Linux.

## Improvements ##

We could replace the interactive part of this with parameters but
since this only needs to be run once I don't usually bother with that.

If (like me) you have all your project files in a single directory
then you could simply share that directory when you first create the
Docker host.

## Open Questions ##

  * Does this problem exist on Linux hosts for Boot2Docker?
  * Is this something that should be included in Boot2Docker or Docker Machine?


