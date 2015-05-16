---
author: steshaw
comments: true
date: 2008-09-15 02:30:20+00:00
layout: post
slug: hyperproductive-monadic-programmer-for-the-21st-century
title: Hyperproductive Monadic Programmer for the 21st Century
wordpress_id: 90
categories:  Programming
tags: - Category Theory, Functional Programming, Haskell, Monads, Productivity, Scala
---

I recently attended the "Introduction to Scala" course at [Working Mouse](http://workingmouse.com/). The course was run by [Tony Morris](http://tmorris.net/) with the help of Tom Adams.  I had feared that the course would be a introduction to Scala with Haskell-coloured glasses ... and it was just that. However, it was just this that made it interesting. I already know Scala at a basic level so a truly introductory course would have offered little. I knew that Tony was into Haskell and on one hand I wanted to come away with an idea of what a monad was and on the other hand I didn't want to learn Haskell with Scala syntax. Luck would have it that there turned out to be just two attendees - myself and John Ryan-Brown. Tony was able to accelerate through the introductory material with help from Tom Adams. This freed us up to begin working on monads and emulating type-classes in Scala. It was a really wonderful course that I can't do justice to in this short post. I did come away knowing what a monad was (but now I'm not quite so sure). I did learn Scala through "Haskell glasses" but that was what was really wonderful about the course.

So what are monads? Well it appears to be an "ultimate interface" with 3 special methods - return (also called unit), bind and join (where join can be derived from return and bind). My current understanding is that monads are the "ultimate iterator" but I figured I'm supposed to understand that they are an "abstraction over computation". This is going to take a while to sink in. Here are the signatures for the 3 special methods:

``` haskell
  return :: Monad m => a -> m a
  bind   :: Monad m => m a -> (a -> m b) -> m b
  join   :: Monad m => m (m a) -> m a
```

In terms of List, return is cons, bind is flatMap and join is flatten. I wasn't familiar with flatMap but it's a more general version of map. Map can be implemented in terms of bind/flatMap and unit/cons.

``` scala
    List(1, 2, 3) map (n => n + 1)
    List(1, 2, 3) flatMap (n => List(n + 1))
```

Since then I've been learning a little more about Haskell and Category Theory. It's really great to have a new avenue of things to study. Haskell certainly has come a long way since I looked at it last.

Oh and the title of this post... Well it's kind of a bad joke from day 3. After 3 days of indoctrination I realised that it was leading to the conclusion that a new breed of programmer was required - the hyper-productive monadic programmer for the 21st century. This new breed of programmer would eschew side effects and even OOP in preference to algebraic data types, type classes, implicits, higher order functions, monads and higher kinds. They would impress their friends with deep knowledge of mathematical principles and have an IQ 50 points above decent developers of today. These programmers would be trained to be 10x more productive than their imperative colleagues (coding in Java and C#) - allowing some of us to retire for a better life (perhaps as an economist or financial advisor). All that remains is to work out how much of this is hyperbole and how much sound.
