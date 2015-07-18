---
layout: post
title: Turning on Pygment Syntax Highlighting in Jekyll
---

# FIXME: this is not necessarily correct #

By default Pygment Syntax Highlighting was not enabled in my Jekyll
Bootstrap site. Here's how I fixed it.

I noticed that the site data object had a setting 'site.pygments' which was set to {{ site.pygments }}.