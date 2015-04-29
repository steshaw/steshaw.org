---
author: steshaw
comments: true
date: 2004-08-22 10:46:50+00:00
layout: post
slug: swingworker-race-condition
title: SwingWorker race condition
wordpress_id: 9
categories: Programming
tags: Erlang, Java, Oz, Swing
---

I was reading about the problems related to shared state concurrency (as opposed to message passing concurrency as in Erlang and Oz). I came across the following [interesting bug described on the wiki](http://c2.com/cgi/wiki?SwingWorkerRaceCondition) discovered by Luke Gorrie. There is also a [reference to a Sun article](http://java.sun.com/products/jfc/tsc/articles/threads/update.html) describing the bug and the solution. This is ancient history but probably a problem misunderstood by many Java programmers.
