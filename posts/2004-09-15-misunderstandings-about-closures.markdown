---
author: steshaw
comments: true
date: 2004-09-15 18:12:43+00:00
layout: post
slug: misunderstandings-about-closures
title: Misunderstandings about closures
wordpress_id: 14
categories: Programming
tags: functional-programming, csharp, java
---

Even the "big names you know" in the Java software development community [can make mistakes when it comes to closures](http://www.almaer.com/blog/archives/000435.html).

Gavin King thinks that closures wouldn't work in Java because of checked exceptions. However, since the use of checked exception is optional you can use "closures" (annonmous inner classes) pretty well if you either don't use checked exception or alternatively wrap checked exceptions with unchecked exception (like the JDBC template in Spring). I was wondering if it would be possible to have you cake and eat it too on this point with Java 1.5 generics - another poster says it is possible to parameterise on the checked exceptions. I hope that's true because that's the best of both worlds - "closures" and checked exceptions - or at least living life without wrapping every last damn checked exception in an unchecked one ;-).

James Strachan commented that closures have made it into C# 2.0. Another poster correctly pointed out that this is just *not* the case. I can understand why you'd thnk that - you really have to read between the lines in those Microsoft articles ;-). With all the good .NET stuff coming out of Microsoft lately I'm surprised they didn't correct this properly in C# 2.0. I much prefer their implementation of generics - it's not based on type erasure like in the Java.

Martin Fowler (if you follow the link through to his article) is right on the money. Closures are good. Lisp is good. Ruby is good. Smalltalk is good. You gotta love Martin.
