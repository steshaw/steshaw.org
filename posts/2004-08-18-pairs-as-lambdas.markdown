---
author: steshaw
comments: true
date: 2004-08-18 12:37:07+00:00
layout: post
slug: pairs-as-lambdas
title: Pairs as lambdas
wordpress_id: 8
categories: Programming
tags: Scheme
---

The [SICP video lectures](http://swiss.csail.mit.edu/classes/6.001/abelson-sussman-lectures/) talk about how data is not intrinsic. That is, once you have lambda, you have enough to create all the data structures you want. Of course that is without caring for efficiency.

Here's some code I was mucking around with the other night:

``` scheme
; Implement pairs (cons, car, cdr) in terms of lambda.

(define cons
  (lambda (a b)
    (lambda (x)
      (cond ((eq? x 'car) a)
            ((eq? x 'cdr) b)
            (else (error "bad dispatch"))))))

(define car
  (lambda (pair) (pair 'car)))

(define cdr
  (lambda (pair) (pair 'cdr)))

; Example to type into the scheme repl.
(define a (cons 3 4))
a                 ; => a procedure
(car a)           ; => 3
(cdr a)           ; => 4
(a 1)             ; error "bad dispatch"

; The following attempts to work out what "error" does. This example will
; probably display "1" and then exit to the repl with "bad dispatch" error.
; It may not as Scheme doesn't define the order of evaluation for arguments to
; a combination.
(+ (display "1\n") (a 99) (display "2\n"))
```
