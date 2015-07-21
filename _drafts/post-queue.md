---
layout: page
title: Post Queue
---

This page is a list of possible posts and resources for writing them.

# Fork the CLI

A document on installing from a fork of the CLI so that you can a) work with the latest and b) contribute back

You can also install the Azure Xplat-CLI from sources using git and npm.

git clone https://github.com/Azure/azure-xplat-cli.git
cd ./azure-xplat-cli
npm install

See https://github.com/Azure/azure-xplat-cli/wiki/Running-Tests for instructions that describe how to run the test suite.

# Configure Autocomplete in the CLI

Auto-complete is supported for Mac and Linux.

To enable it in zsh, run:
echo '. <(azure --completion)' >> .zshrc

To enable it in bash, run:
azure --completion >> ~/azure.completion.sh
echo 'source ~/azure.completion.sh' >> .bash_profile

# Azure CLI modes

Starting from 0.8.0, we are adding a separate mode for Resource Manager. You can use the following command to switch between the
* Service management: commands using the Azure service management API
* Resource manager: commands using the Azure Resource Manager API

They are not designed to work together.
azure config mode asm # service management
azure config mode arm # resource manager

For more details on the commands, please see the command line tool reference and this How to Guide

# Create a Docker Host with the CLI

Usage is same as standard vm create.
azure vm docker create [options] <dns-name> <image> <user-name> [password]


This command only supports Ubuntu 14.04 based images. Docker is configured on the VM using HTTPS as described here: http://docs.docker.io/articles/https/ By default, certificates are put in ~/.docker, and Docker is configured to run on port 4243. These can be configured using new options:
-dp, --docker-port [port]              Port to use for docker [4243]
-dc, --docker-cert-dir [dir]           Directory containing docker certs [.docker/]


After the VM is created. It can be used as a Docker host with the -H option or DOCKER_HOST environment variable.
docker --tls -H tcp://<my-host>.cloudapp.net:4243 run


Note: To run docker commands on windows make sure ssl agent is installed.


# Learning the Azure REST API using the CLI Tools

Setting up Fiddler for CLI

You need to set the following environment variables to capture the HTTP traffic generated from the execution of xplat cli commands
set NODE_TLS_REJECT_UNAUTHORIZED=0
set HTTPS_PROXY=http://127.0.0.1:8888



Want to know the underlying HTTP traffic when you execute the command

You can use the -vv option to see the actual REST requests on the console.
azure site create --location "West US" mytestsite -vv




 