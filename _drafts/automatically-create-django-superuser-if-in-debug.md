---
layout: post
title: Automatically Create a Django SuperUser if in Debug
tags: [django, devtest]
---

Django applications requite a SuperUser for accessing the admin
interefaces. When running in a test enviornment the creation of such a
user can be a bit of a chore, especially if you frequenlty rebuild the
database with test data in it. Here's how to add a test user whenever
you run 'syncdb' while in DEBUG mode.

https://djangosnippets.org/snippets/1875/