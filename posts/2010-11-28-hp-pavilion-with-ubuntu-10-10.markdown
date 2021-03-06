---
author: steshaw
comments: true
date: 2010-11-28 02:44:29+00:00
layout: post
slug: hp-pavilion-with-ubuntu-10-10
title: HP Pavilion with Ubuntu 10.10
wordpress_id: 528
categories: Programming
tags: hardware, macbook, linux
---

I've been asked for an update of my [experiences with my HP Pavilion dv6
3042TX](/posts/2010/05/22/stonking-new-laptop/) - in particular with Ubuntu.
A [reader](http://steshaw.org/posts/2010/05/22/stonking-new-laptop/#comment-2032899877)
has found that this notebook can now be purchased here in Australia for
$1,299. That is a fine price, indeed! However, I must say that I sometimes
have regrets about not getting a [Mac](http://www.apple.com/au/macbookpro/).
Here are some of my experiences and advice:


### The good

* Aesthetics are good. Quite a good looking laptop. Not as good looking as the
MacBook Pro.

* Quad-core. 8G RAM. 1G graphics.

* The keyboard is fine (our reader had heard otherwise). Compared with MBP
  it even has PgUp and PgDn keys :)

* The touchpad is fine (again, not sure why our reader would have heard
  otherwise). Not quite as pleasant as the MacBook Pro touchpad though -
  particularly for scrolling.

* Some ports that MacBooks don't have: HDMI out, eSATA out, fingerprint
  reader, Blu-ray.

* Running GeekBench on Ubuntu 10.10 can yield up to 6300, so I assume that it
  is more performant than Windows 7, which gets about 5600.


### The bad

* Battery life is only 1.5hr - just for light web-browsing tasks

* When running Ubuntu 64-bit, you will run into the 100% CPU problem caused
  by npviewer.bin. AFAIK it's a program that helps interoperate with the
  32-bit Adobe Flash plugin because there's no 64-bit one for Linux yet...

* The fingerprint reader isn't used for authentication out-of-the-box on
  Ubuntu 10.10 although I haven't searched for any solution (pain threshold
  too low).


### The ugly

* It runs hot. Even when doing little CPU-intensive work, the fans turn on, and
  it sounds like it's going to take off! I've had one or two blue-screens of
  death which I imagine are related to the heat. Lately, I've been using
  FlashBlock, which seems to have improved things somewhat.

* With Ubuntu 10.10 after resuming from hibernate I get odd graphics
flickering "effects" which is particularly bad when dragging or playing
video. You will end up rebooting to resolve it. I have found no solution for this.

* With Ubuntu 10.10, the touchpad will not work well. Dragging sends the pointer
  crazy, and right-click does not work at all. I found a solution
  <https://bugs.launchpad.net/ubuntu/maverick/+source/linux/+bug/582809/comments/94>,
  but unfortunately, now the pointer moves too slowly and increasing the
  sensitivity does not work.


## Advice

### Stick with Ubuntu 10.04

The touchpad problems didn't happen with Ubuntu 10.04, and I'm reasonably certain
that the screen flickering following a resume didn't occur either. So if you're
going to install Ubuntu, I'd currently recommend 10.04.

### Run Windows 7 with Ubuntu 10.10 in VirtualBox

Sadly, this is the option I've currently adopted. This way, I have no problems with
Google Chrome and npviewer.bin because there's a 64-bit version of flash.
It also has other good effects such as being able to run the latest version of
Skype, have my fingerprint reader work for logging in (this is quite a time
saver because I tend to use strong passwords). Of course, to get software
development done, I installed Ubuntu 10.10 with VirtualBox. In this way, I have
no problems with the touchpad. Running the operating system that the
manufacturer intended has certainly caused fewer headaches and time wasters.
Using VirtualBox seems quite performant, and I'm not stuck with a compromise
such as Cygwin.

### Buy a Mac

The other option is, of course, to buy a MacBook. Since I already have an iMac
in case I need more power, I've been thinking about purchasing an 11-inch MacBook
Air next year. I've tested one in-store, and it seems quite nimble for such a
little beast, and the screen resolution is the same as my current laptop —
1366x768. I'd certainly have no more need for my 11.6" netbook (which won't run
Ubuntu Unity btw because of gma500/poulbo graphics driver issues - sigh!).
Perhaps the 11-inch wouldn't cut it for Java development though. I haven't tried
IntelliJ on it in-store yet. A fine but more expensive option is the 13-inch
MacBook Air. The same resolution as a 15-inch" MacBook Pro. Currently the
13-inch
MacBook Air will set up back $2,078.00 including 4G RAM and 3-year warranty. If
I had to choose again right now, I'd be picking between 11-inch and 13-inch MacBook
Airs.

Since I won't be purchasing a new notebook until next year, I am hoping that
the rumoured April MacBook Pro update will make the decision easier. Hoping for
higher resolution displays like MacBook Air, cheaper SSD storage option,
quad-cores, Mac OS X Lion and more affordable 8G RAM option. Hopefully, a
combination of Apple and a rising AUD can deliver.  The AUD could possibly come
crashing down before then though :(.

## Plea to Canonical and manufacturers

Perhaps it's just that 10.10 is a disaster (at least running native/raw on HP
hardware). Still, I can't help but think that it's imperative that Canonical find a
way to have manufacturers buy into Ubuntu and test/preinstall it on their
hardware.
Dell was doing this in the US and EU for some laptops
I used to enjoy the days
of searching for solutions for hardware problems, diving into configuration
files and configuring X etc. I learnt a lot through those experiences. However,
now that I'm older, I suppose, I value my time more. I hear this argument from
Apple fanboys all the time. Unfortunately, it's true. I do think that Linux and
Ubuntu, in particular, is a better software development platform. The wealth of
software available using APT is a big part of that. Also, that APT uses binary
packages. Easy software installations aren't so important if you don't
experiment with new programming languages and libraries etc. that often.
