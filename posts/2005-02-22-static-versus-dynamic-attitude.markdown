---
author: steshaw
comments: true
date: 2005-02-22 05:26:00+00:00
layout: post
slug: static-versus-dynamic-attitude
title: Static versus dynamic attitude
wordpress_id: 27
categories: - Programming
tags: - ActionScript - Dynamic Typing - Groovy - Java - JavaScript - Programming Languages - Python - Ruby - Static Typing
---

I think Bill is dead-on-the-money with [the different-language, different-mindset thing](http://www.artima.com/weblogs/viewpost.jsp?thread=92979). Java can make you feel guilty alright :-). Even when you can get over your own guilt, there's the struggle with your colleagues who may not have a dynamic mindset.

I've been programming in JavaScript lately (actually more ActionScript 2.0 but some browser based JavaScript too). You'd probably return a single object there rather than multiple:
[sourcecode language="javascript" gutter="false"]
    var context = ExamplePage.process();
[/sourcecode]
followed by code using context.forumID, context.reply, context.subject and context.body.

Single objects are constructed easily in JavaScript:
[sourcecode language="javascript" gutter="false"]
    function process() {
        // Do some processing...
        return {
            forumID: ...,
            reply: "a reply",
            subject: "a subject",
            context: "a context"
        }
    }
[/sourcecode]
This is a very lightweight approach. Another poster had a similar solution in Python. There must be a similar way of doing this in Ruby or Groovy.

It would be great to use Ruby/JRuby, Groovy, JavaScript, Python/Jython or whatever on the Java platform. What's needed for adoption is buy-in by vendors like Sun and IBM (so that project managers and other developers don't have a fit when something without the .java or .xml file extension is checked into the repository). It would be nice to have support for these languages in Eclipse (say) with all the usual bells-and-whistes Java programmers have come to rely on to get stuff done - code completion, Javadoc lookup, hyperlinking, refactoring etc. Groovy seems to have alot of momentum including a JSR thing - so maybe something along these lines is not too far away. Maybe it's already there and I just haven't looked!

BTW - have you heard about NoXML? It's this great new XML technology...
