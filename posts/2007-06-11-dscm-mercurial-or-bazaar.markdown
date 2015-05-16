---
author: steshaw
comments: true
date: 2007-06-11 22:14:47+00:00
layout: post
slug: dscm-mercurial-or-bazaar
title: DSCM: Mercurial or Bazaar?
wordpress_id: 68
categories: Programming
tags: Bazaar, DVCS, Git, Mercurial
---

I just recently switched over to using Mercurial for all SCM needs. I figured that the Mercurial team had solved the rename problem by now. However, I just noticed [Mark Shuttleworth's entry](http://www.markshuttleworth.com/archives/123) on the topic. It seems Bazaar could still be in the running as the DSCM of choice. However with Sun choosing it for OpenSolaris and now OpenJDK it kinda becomes inevitable for Java developer to go with Mercurial. After all, Mercurial has Eclipse and Netbeans plugins. But then again, I love to restructure my tree... Then again I don't merge with anyone right now ;).

[Why MoinMoin chose Mercurial](http://moinmoin.wikiwikiweb.de/NewVCS)

[Why OpenSolaris chose Mercurial](http://www.opensolaris.org/os/community/tools/scm/history/) (GIT and Bazaar being the other finalists)

[Why Mozilla chose Mercurial](http://weblogs.mozillazine.org/preed/2007/04/version_control_system_shootou_1.html) - Bazaar and Mercurial were the final 2

On the whole, it seems that GIT lacks the win32 support and is a bit weird in that it doesn't explicit track renames and guesses about them. Bazaar has some performance issues but otherwise is a good candidate. Mercurial does copy+delete renames but otherwise has great performance, portability and usability.

I'm happy with my choice of Mercurial but Bazaar will be the one to watch as they work towards 1.0 focusing on performance and documentation improvements.
