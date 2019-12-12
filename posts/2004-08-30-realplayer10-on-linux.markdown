---
author: steshaw
comments: true
date: 2004-08-30 17:42:40+00:00
layout: post
slug: realplayer10-on-linux
title: RealPlayer10 on Linux
wordpress_id: 13
categories: Programming
tags: linux
---

I was recently having trouble with sound and RealPlayer10 on Linux. It turns
out that RealPlayer10 (and Helix Player) only support the older OSS sound
drivers (rather than the newer ALSA drivers). I was on 2.6.6. I downloaded
2.6.8.1 and this time only compiled the OSS drivers and not the ALSA ones.
Be aware that you should not (perhaps cannot) load both OSS and ALSA
drivers.
