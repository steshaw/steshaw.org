---
author: steshaw
comments: true
date: 2009-01-29 22:43:01+00:00
layout: post
slug: webbeans-java-contexts-and-dependency-injection
title: WebBeans => Java Contexts and Dependency Injection
wordpress_id: 101
categories: - Programming
tags: - Dependency Injection, Guice, Java, JCDI, JEE, Seam, Web, WebBeans
---

I've been watching the WebBeans/JSR-299 specification for quite some time. After some discussion on the webbeans mailing list, the name was recently changed to Java Contexts and Dependency Injection. This removes the "dependency" on "Web" part. Since it's effectively a new component model for Java, it didn't make sense to restrict it to Web environments. The new name is long and not as catchy ... maybe it'll become known as JCDI.

[An updated public draft is now available](http://in.relation.to/Bloggers/RevisedPublicDraftOfJSR299JavaContextsAndDependencyInjection). Other useful information - particularly the introductory guide - can be found on the [Seam Framework wiki](http://www.seamframework.org/WebBeans).

The specification draws much from [Seam](http://seamframework.org) and [Guice](http://code.google.com/p/google-guice/) and consequently Gavin King and Bob Lee. Congratulations to all involved in the specification. It's really worth looking at particularly if you haven't been using Seam 2 or Guice 2. I find myself particularly drawn to Guice 2. I hope they release it soon :).
