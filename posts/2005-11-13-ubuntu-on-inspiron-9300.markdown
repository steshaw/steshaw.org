---
author: steshaw
comments: true
date: 2005-11-13 19:55:00+00:00
layout: post
slug: ubuntu-on-inspiron-9300
title: Ubuntu on Inspiron 9300
wordpress_id: 31
categories: Programming
tags: gnome, linux
---

I've just been trying out the Live CD of Unbuntu 5.10 this afternoon... and into the evening. I'm really impressed. I'm *posting* this from my first boot into the live cd! It recognised my hardware very well - the paritions from my external USB drive were mounted, sound card worked, graphics card worked, wireless usb mouse works, touchpad works. Excellent! Just no wireless networking :-(. To get wireless networking working I had to 'modprobe ipw2200' and configure the wireless network: 'ipwconfig eth1 essid ' & 'ipwconfig eth1 key ', and lastly 'dhclient' to request an ip address. You can 'sudo' to execute root commands or simply reset the root password via sudo "sudo passwd" and then "su -".

I changed the Gnome theme to Clearlooks which I reckon is much nicer that the default Unbuntu theme which is very brown! I'm only on the live cd but I did try installing things - Eclipse, k3b, Gnome desklets, Gmail notifier (and heaps of other stuff). The "Applications->Add Applications" menu item makes me want to set my Dad up with this distro. Dad has enjoyed Debian in the past but installing software was painful - this is a breeze.

I wish I was able to eject the live cd in order to test DVD playback but I guess I have to go for a full install for that. I may just be replacing Gentoo after only just getting it up-to-date after behind behind the times for afew months.

A feature I really miss in the default window manager (metacity) is maximising vertically. I used to use this all the time when I was using another window manager (WindowMaker or Sawmill - can't remember which). Well, I discovered you can bind a key to do this with metacity. In Unbuntu, go to  "System->Preferences->Keyboard Shortcuts". Looks for "Maximize window vertically" and and associate a key. I used ' F11' which I had seen mentioned on the forums. I only wish I knew how to add this to the window menu cause that's where I'm used to using it...

Some useful resources:

Getting MP3 players, DVD players, Macromedia Flash, Java and other "restricted" non-free stuff going
[https://wiki.ubuntu.com/RestrictedFormats](https://wiki.ubuntu.com/RestrictedFormats)

Unbuntu starter guide
[http://www.ubuntuguide.org/](http://www.ubuntuguide.org/)
Seems like a more up-to-date version of this is available on the live cd and presumably with a regular install. Just click on the 'Help (get help with Gnome)' icon or choose System->Help and then click 'Unbuntu 5.10 Starter Guide'.
