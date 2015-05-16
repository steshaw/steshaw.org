---
author: steshaw
comments: true
date: 2007-06-18 14:39:20+00:00
layout: post
slug: exceptions-checked-or-not
title: Exceptions – checked or not?
wordpress_id: 69
categories:  Programming
tags: C#, Java, Programming Languages, Scala
---

The [Java Posse #127](http://javaposse.com/index.php?post_id=226047) podcast talks about the possibility of removing checked exceptions from the Java language. The JavaPosse folks seem to universally like them. No one knew what Scala did with respect to checked exceptions. Turns out that it [does not have them](http://www.scala-lang.org/docu/faq.html#id2243896)!



<blockquote>
3.3. Why are there no throws annotations on methods, unlike in Java?

Compile-time checking of exceptions sounds good in theory, but in practice has not worked well. Programmers tend to write catch clauses that catch too many exceptions, thus swallowing exceptions and decreasing reliability.
</blockquote>



If you haven't seen the Scala language yet, check [Martin Odersky's Google Techtalk](http://video.google.com/videoplay?docid=553859542692229789).

I tend to avoid checked exceptions. This is the way that the Spring folks have gone and - of course - [Anders Hejlsberg](http://www.artima.com/intv/handcuffs.html). Anders did a great job designing the C# language.

I'm still digging into [an article on dev2dev](http://dev2dev.bea.com/pub/a/2006/11/effective-exceptions.html) which promotes checked exceptions and points out that that the times they get annoying is where the Java API was poorly designed. For me this still points that checked exceptions are a experimental language feature perhaps best left out of industry programming languages for now.
