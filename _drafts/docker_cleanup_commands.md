---
layout: post
title: Docker Cleanup Commands
tags: [docker]
---

FIXME: rewrite below, not my content (credit to https://www.calazan.com/docker-cleanup-commands/)

I've been working quite a bit with Docker these last few weeks and one thing that I found really annoying was all these unused containers and images taking up precious disk space.

I wish Docker has a 'docker clean' command that would delete stopped containers and untagged images. Perhaps sometime in the near future as the project is very active. But for the time being, these commands should do the job.

Kill all running containers
docker kill $(docker ps -q)


Delete all stopped containers (including data-only containers)
docker rm $(docker ps -a -q)


Delete all 'untagged/dangling' (<none>) images
docker rmi $(docker images -q -f dangling=true)

Delete ALL images
docker rmi $(docker images -q)

It might also be useful to create bash aliases for these commands, for example:
# ~/.bash_aliases

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'





Teddy Martin  





This is my favorite cleanup command. Just set search term to the common phrase. GB is a good one for cleaning up big containers.

docker rmi $(docker images | grep ${search_term} | grep -o -E " [0-9,a-f]{12} ")

To kill al stopped or exited containers, you can try `docker rm $(docker ps -f status=exited -q)`