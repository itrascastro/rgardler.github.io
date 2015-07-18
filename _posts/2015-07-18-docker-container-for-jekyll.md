---
layout: post
title: Dockerizing a Jekyll Site
tags : [jekyll, docker, container]
---

Having created my GitHub Pages hosted blog (powered by Jekyll) I need
a better development environment. Committing and pushing changes to
GitHub before I can see their effect is no good. So here are my notes
on getting a Docker container with Jekyll up and running for local
development.

## Docker Hub Containers

There are a bunch of Jekyll containers on [Docker
Hub](https://registry.hub.docker.com/search?q=jekyll&searchfield=).

The first I tried was the official
[jekyll/jekyll](https://registry.hub.docker.com/u/jekyll/jekyll/)
one. But it didn't immedietely work for me. So I tried to the most
commonly downloaded one at the time,
[grahamc/jekyll](https://registry.hub.docker.com/u/grahamc/jekyll/).

{% highlight bash %}
  docker run --rm -v "$PWD:/src" -p 4000:4000 -t jekyll grahamc/jekyll serve -H CLIENT_IP --drafts
{% endhighlight %}

Now just visit the site at http://CLIENT_IP:4000

This isn't perfect, for example when viewing the index page we don't
see excerpts from the posts (as we do on the live site) however, we
see the whole post instead. But it is a good start.

## Windows Gotchas

Shared folders do not currently work as expected in Boot2Docker as
expected, as a workaround run the following script (stored in
script/dev.sh). Note that this script will start the container and
mount the shared folder.

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

docker run --rm -v "$PWD:/src" -p 4000:4000 -t jekyll grahamc/jekyll serve -H $CLIENT_IP --drafts --force_polling
{% endhighlight %}
