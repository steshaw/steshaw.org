---
author: steshaw
comments: true
date: 2004-09-27 13:46:33+00:00
layout: post
slug: movitz-a-lisp-os-platform
title: Movitz – a Lisp OS platform
wordpress_id: 17
categories: Programming
tags: Lisp, Operating Systems, Scheme
---

Wow. You hear alot of rumours about Lisp-based operating systems but you rarely come across a project that appears active. [Movitz](http://common-lisp.net/project/movitz/) looks like a promising *active* LispOS project! It's goal is to provide a development platform to run CL-based kernels on x86 PCs "on the metal". I guess these restrictions make it doable. I'd prefer to see CL or Scheme combined with Linux or FreeBSD kernel so that you could still have a viable usable system and also experiement with OS ideas using lisp. In this respect, [Schemix](http://www.abstractnonsense.com/schemix/) looks interesting. It's a Scheme interpreter (based on [TinyScheme](http://tinyscheme.sf.net)) patched into the Linux kernel. I haven't looked at it closely but imagine that it's interpreted nature means that it is probably only useful for early prototyping of ideas and certainly for exploring and learning about the kernel.
