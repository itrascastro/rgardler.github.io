---
layout: page
title: Install the Cross Platform Azure CLI
tag: [azure, cli]
---

There are many ways of managing your Azure subscription and the
resources within it. One of the most flexible is with the Azure
Command Line Interface. Here's how to install the cross platform CLI
on Linux, OS X or Windows.

## Installation

The Azure Cross Platform Command Line Interface (Azure X-Plat CLI) is
written in Node.js. Therefore, the first thing you must do is install
Node.js from [https://nodejs.org/](https://nodejs.org/).

There are CLI installers available for OS X and Windows which will
isntall Node for you, but I prefer to install using the Node Package
Manager (NPM), it's just as easy. It's the NPM approach I describe
below.

## Installing Azure X-Plat CLI

Once you have installed Node and NPM you simply run the following
command to install the Azure X-Plat CLI:

{% highlight bash %}
npm install azure-cli --global
{% endhighlight %}

On Linux you will likely need to use 'sudo'.

## Obtaining an Azure Subscription

If you already have an Azure subscription you can skip to the next
section. If you have an MSDN subscription then you can activiate your
[includd Azure
credits](http://azure.microsoft.com/pricing/member-offers/msdn-benefits-details/). Alternatively
you can start a [free
trial](http://www.windowsazure.com/en-us/pricing/free-trial/?WT.mc_id=AA4C1C935).

## Configuring your Azure Subscription

In order for the command line tools to work with your Azure
subscription you need to configure it with your credentials. It is
possible to manually login to a subscription using:

{% highlight bash %}
azure login 
{% endhighlight %}

However, this method makes it difficult to script the management of
your Azure resources. If you want to script things, or even just
prevent the need to log in each time you use the tools, you can import
your subscription credentials into your installation of the command
line tools. Run the command:

{% highlight bash %}
azure account download 
{% endhighlight %}

This will open the Azure login page in your browser and, after
authenticating your account, will start a download of your
subscription credentials. Save the file somewhere convenient and then
import the account details into the CLI tool by running the following
command:

{% highlight bash %}
azure account import [path] 
{% endhighlight %}

### Managing Multiple Subscriptions

If you have more than one subscription attached to your live id you
will need to ensure that the right subscription is being used. To see
which subscription is currently active run the following command:

{% highlight bash %}
azure account show
{% endhighlight %}

If you want to change the selected subscription you can list which
subscriptions are available with:

{% highlight bash %}
azure account list and
{% endhighlight %}

Finally, you can change the active subscription with:

{% highlight bash %}
azure account set [ACCOUNT] 
{% endhighlight %}

## Upgrading to the Latest Version

Like all Node packages you can upgrade to the latest version with the
'upgrade' command:

{% highlight bash %}
npm -g upgrade azure-cli
{% endhighlight %}

## Using the Azure cross platform CLI Tools

That's it! You are now ready to use the command line tool to manage
your Azure subscription. The features of the [CLI are well
documented](https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-command-line-tools/),
one of the first things you could try is deploying an [ARM
template](http://azure.microsoft.com/en-us/documentation/templates/).

