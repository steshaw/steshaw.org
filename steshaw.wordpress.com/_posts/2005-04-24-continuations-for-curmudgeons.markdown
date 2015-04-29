---
author: steshaw
comments: true
date: 2005-04-24 20:04:00+00:00
layout: post
slug: continuations-for-curmudgeons
title: Continuations for curmudgeons
wordpress_id: 28
categories: - Programming
tags: - call/cc - Continuations - Programming Languages - Ruby - Scheme
---

Sam Ruby has a much praised blog entry entitled "[Continuations for Curmudgeons](http://www.intertwingly.net/blog/2005/04/13/Continuations-for-Curmudgeons)".

I didn't like the tone of the article which seem to treat the C programmers as some kind of dinasaur with no interest in other languages (or language features).

There was no mention of Scheme. When learning about continuations I think it's best to learn from the source. That source appears to be the Scheme programming language. R5RS includes call-with-current-continuation function usually shortened to call/cc. A really good introduction to Scheme with [coverage of continuations](http://www.ccs.neu.edu/home/dorai/t-y-scheme/t-y-scheme-Z-H-15.html#node_chap_13) for [non-trivial applications](http://www.ccs.neu.edu/home/dorai/t-y-scheme/t-y-scheme-Z-H-16.html#node_chap_14) is contained in Dorai Sitaram's [Teach Yourself Scheme in Fixnum Days](http://www.ccs.neu.edu/home/dorai/t-y-scheme/t-y-scheme.html) (TYSiFD).

Sam seems to have some confusion about continuations and there relationship to closures, iterators, generators and coroutines. Just because a language has a "yield" keyword doesn't mean it has first class continuations. Yield is usually used for generators. One of the highlights of TYSiFD is implementing coroutines with continuations.

Ruby supports first class continuations. The callcc method is available from the Kernel class. I played around with the code from the Ruby documentation of the [Continuation class](http://www.ruby-doc.org/core/classes/Continuation.html). You really don't need call/cc for the contrived example there:

[sourcecode language="ruby"]
original_guys = ["Freddie", "Herbie", "Ron", "Max", "Ringo"]

puts "method 1: (first-class) continuation"
guys = original_guys.clone
callcc{|$k|}
puts(message = guys.shift)
$k.call unless message =~ /^R/;

puts
puts "method 2: continuation with different way of setting global"
guys = original_guys.clone
callcc{|k| $k = k}
puts (message = guys.shift)
$k.call unless message =~ /^R/;

puts
puts "method 3: just a loop"
guys = original_guys.clone
loop {
  message = guys.shift
  puts message
  if (message =~ /^R/)
    break
  end
}

puts
puts "method 4: (tail) recursion using methods/functions"
puts "          Ugly - needs guys to be global variable."
$guys = original_guys.clone
def myloop
  message = $guys.shift
  puts message
  unless message =~ /^R/
    myloop
  end
end
myloop

puts
puts "method 5: (tail) recursion using blocks"
guys = original_guys.clone
myloop = Proc.new{
  message = guys.shift
  puts message
  unless message =~ /^R/
    myloop.call
  end
}
myloop.call

puts
puts "method 6: using each and catch/raise"
guys = original_guys.clone
catch (:early_exit) {
  guys.each {|item|
    puts item
    if item =~ /^R/
      throw :early_exit
    end
  }
}
[/sourcecode]
