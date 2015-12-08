---
layout: post
title: Create a Custom Azure CLI
tags: [docker, Azure, CLI]
---

The Azure CLI is a great way to interact with Azure. In this post I'll
describe how I create a Docker containerthat contains the Azure CLI
and a set of useulf files and scripts that I commonly use. 

# Pull the Base Container

```
$ docker pull microsoft/azure-cli'
Using default tag: latest
latest: Pulling from microsoft/azure-cli

8f7be6207f59: Pull complete
53462566a306: Pull complete
21dfa4ecc36e: Pull complete
575489a51992: Already exists
6845b83c79fb: Already exists
Digest: sha256:95da2595b166aa5f3901d64ed20bc7af9817e6308a3e6c173069e1a1ea99c536
Status: Downloaded newer image for microsoft/azure-cli:latest
```

$ docker run -it microsoft/azure-cli
root@eded18c4cd7f:/# azure login
info:    Executing command login
\info:    To sign in, use a web browser to open the page https://aka.ms/devicelogin. Enter the code UNIQUECODE to authenticate. If you're signing in as an Azure AD application, use the --username and --password parameters.
-info:    Added subscription ???
info:    Added subscription ???
info:    Added subscription ???
info:    Added subscription ???
info:    Added subscription ???
info:    Setting subscription "???" as default
+
info:    login command OK
root@eded18c4cd7f:/# exit
exit

$ docker commit ede
bcadbcf34eefb7d7334e7e3f7d7cefac24b48844eca1a87077c76dba950a2a74

$ docker tag bca rgardler/azure-cli

## Create a ***private** repository on Docker Hub

## Login to docker hub on your client (here I have already logged in so
am not asked for my credentials)

$ docker login
Username (rgardler): rgardler
WARNING: login credentials saved in /home/rgardler/.docker/config.json
Login Succeeded

## Push your image to your private repository

$ docker push rgardler/azure-cli
The push refers to a repository [docker.io/rgardler/azure-cli] (len: 1)
bcadbcf34eef: Image successfully pushed
21dfa4ecc36e: Image already exists
53462566a306: Image successfully pushed
8f7be6207f59: Image successfully pushed
6845b83c79fb: Image already exists
575489a51992: Image successfully pushed
latest: digest: sha256:30a3b0a24969085bcd74d196598e8a39326d8264a6d09e9a000abfb0716914df size: 10885
Now I have a private docker container that contains my Azure subscription credentials.

# Using my personal CLI container

## Run in interactive mode

$ docker run -it rgardler/azure-cli
root@699eae31bb56:/# 

### Check you are logged in

root@699eae31bb56:/# azure account show
info:    Executing command account show
data:    Name                        : Microsoft Azure Internal Consumption
data:    ID                          : 325e7c34-99fb-4190-aa87-1df746c67705
data:    State                       : Enabled
data:    Tenant ID                   : 72f988bf-86f1-41af-91ab-2d7cd011db47
data:    Is Default                  : true
data:    Environment                 : AzureCloud
data:    Has Certificate             : No
data:    Has Access Token            : Yes
data:    User name                   : rogardle@microsoft.com
data:
info:    account show command OK

## One-off command mode

$ docker run rgardler/azure-cli azure account show
info:    Executing command account show
data:    Name                        : Microsoft Azure Internal Consumption
data:    ID                          : 325e7c34-99fb-4190-aa87-1df746c67705
data:    State                       : Enabled
data:    Tenant ID                   : 72f988bf-86f1-41af-91ab-2d7cd011db47
data:    Is Default                  : true
data:    Environment                 : AzureCloud
data:    Has Certificate             : No
data:    Has Access Token            : Yes
data:    User name                   : rogardle@microsoft.com
data:
info:    account show command OK

# Creating an Alias

$ alias azure="docker run rgardler/azure-cli azure"
$ azure --version
0.9.10 (node: 0.12.4)

## make the alias permanent

Add the above to your ~/.bashrc file