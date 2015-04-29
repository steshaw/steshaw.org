---
author: steshaw
comments: true
date: 2006-05-24 18:09:00+00:00
layout: post
slug: typecase-for-java
title: Typecase for Java
wordpress_id: 50
categories:
- Programming
tags:
- Java
- Modula-3
- Programming Languages
---

I was just reading Stephen Colebourne's blog. He is the other of [Joda-Time](http://joda-time.sourceforge.net/) which looks to be a useful replacement for java.util.Calendar and java.util.DateTime... but I digress.

I was digging into the blog and found [an entry about adding autocasts to Java](http://www.jroller.com/page/scolebourne?entry=adding_auto_casts_to_java) by reusing the instanceof "syntax". I quite like the proposed "syntax" (which is really nothing, the compiler just detects were you are using instanceof already). The consensus in the blog comments is that there's a problem with the syntax because the variable can be assigned to. However that can be fixed by mearly disallowing assignment to the variable inside the instanceof block. All that said, it is much cleaner to use a special syntax like typecase to do this which introduces a variable binding. In this way, the expression need not just be a variables but could be a full expression - perhaps a method call e.g. the problem is shown by "if (fred.getBar() instanceof FooBar) {".

Of course, this has been done before with the typecase expression like in [Modula-3](http://en.wikipedia.org/wiki/Modula-3). Modula-3 is a very cool but dead language, a prerunner to Java with a more Modula/Pascal syntax. Check out the [language spec for typecase](http://www-plan.cs.colorado.edu/diwan/modula3/typecase.html). Unfortunately the original Modula-3 site, SRC, is down, perhaps try [ SRC later ](http://research.compaq.com/SRC/m3defn/html/typecase.html) or [Google's cache of the original typecase page](http://66.249.93.104/search?q=cache:hHoV1NdS_AYJ:research.compaq.com/SRC/m3defn/html/typecase.html+typecase+modula-3&hl=en&amp;amp;gl=uk&ct=clnk&cd=1).
