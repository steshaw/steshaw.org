---
author: steshaw
comments: true
date: 2004-09-27 13:16:46+00:00
layout: post
slug: wcl-and-shared-libraries
title: WCL and shared libraries
wordpress_id: 16
categories: Programming
tags: lisp, java
---

Just read about [WCL](http://wcl.kontiki.com/), a Common Lisp (CL) implementation I wasn't aware of. The [paper](http://wcl.kontiki.com/downloads/lfp-paper.ps) talks about how CL is compiled to C and linked into a shared library. This allows a memory efficient delivery environment. i.e. CL application share code via shared libraries including the core system/libraries. I missed whether the CL compiler is available at runtime which would be a drawback. Many problems were solved but still afew remained such as relocated data with embedded pointers in the shared library (causing slower startup times), generational GC is not implemented, the compiler could be more sophisticated and there is no thread support. The project appears to be stalled.

I wonder whether other CL implementations such as [GCL](http://www.gnu.org/software/gcl/) and [ECL](http://ecls.sourceforge.net/) using the CL->C method are able to provide sharing through shared libraries?

Java programs have similar problems that WCL attempts to solve for CL. When the same Java program is loaded by separate JVMs (in different processes), they don't share any code. i.e. the classes will be jitted multiple times ...being stored in memory multiple times. I believe that this problem occurs even within the *same* JVM when the class files are loaded via different class loaders! I've yet to confirm that though. This is one of the reasons why Java application take up alot of memory. Seems to be a problem with 1.4.2 anyways. Perhaps 1.5 fixes this problem. Microsoft's CLR deals with this situation by using the assembly is the unit of deployment and having each assembly contain a version number. I imagine that with the CLR (and other CLI implementations), that each assembly is only compiled once within the same process. This doesn't however solve the "multiple process runnings CLRs" problem though I believe there is an ahead-of-time option which stores compiled assemblies in an on-disk cache - this would would likely solve the problem (as long as the compiled assemblies are loaded into shared memory like a shared library).
