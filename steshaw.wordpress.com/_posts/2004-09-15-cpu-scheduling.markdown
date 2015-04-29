---
author: steshaw
comments: true
date: 2004-09-15 21:55:22+00:00
layout: post
slug: cpu-scheduling
title: CPU Scheduling
wordpress_id: 15
categories:
- Programming
tags:
- Lisp
- Operating Systems
---

I'm slowing working my way through the [cs162 lectures from Berkeley](http://webcast.berkeley.edu/courses/archive.html?prog=116&group=57). Just watched the [CPU Scheduling lecture](http://webcast.berkeley.edu/courses/replay.php?prog=116&amp;amp;group=57&date=20040225&rep=real). I had the realisation that CPU scheduling is "just" resource sharing (der), like shoppers sharing the checkout operators on their way out of the store. Alan talked about optimal scheduling algorithms for "perfect" situation. I think it was FIFO was provably optimal when considering time to completion and SRTF (shortest running task first?) was provably optimal when considering average response time. FIFO works when all jobs are the same length, SRFT is more general but you have to guess about how long a job will run. I had the thought that if there are optimal schedulers for certain situations then wouldn't it be great to be able to specify what scheduling algorithm to use for certain processes? You could even allow user-designed schedulers to which you assign your jobs. Then you could have a heirarchy of schedulers and a super-scheduler that moves jobs/tasks between the different schedulers.... or you could use the lottery algorithm that Alan talked about towards the end of the lecture. It has nice properties like avoiding starvation (in particular of long running tasks) and easy to understand fairness. Anyways I still think it would be great to have a Lisp-based operating system, perhaps as a layer above Linux (cause you don't want to write all those device drivers do you) that would allow experimentation with custom scheduling algorithms and heirarchies of schedulers.

The other potentially interesting thing about a LispOS is that you could do away with reserving stack space for each thread. One of the problems with having lots of processes (and threads) is that it consumes alot of memory even if each thread only gets afew kilobytes it mounts up quickly. With Lisp you needn't use the stack to hold "procedure activations", you could put them in the garbage collected heap (actually you might want to optimise that a bit and put them in a special "stack" heap and only move/link them into the gc-heap if necessary). This way threads only take as much "stack" as they need. Also "stack space" grows as required (just as the heap grows as required). Potential problems would be efficiency of the gc-heap - particularly memory allocation speed - and slightly larger activation frames due to embedded pointers.
