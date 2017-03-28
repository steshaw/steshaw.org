
http://stackoverflow.com/questions/586362/pattern-matching-implementation

## Resources

  - "Efficient Compilation of Pattern-Matching" by Philip Wadler. Chapter 5 of [The Implementation of Functional Programming Languages](https://www.microsoft.com/en-us/research/publication/the-implementation-of-functional-programming-languages/) by Simon Peyton Jones.
  - [Compiling Pattern Matching to Good Decision Trees](http://pauillac.inria.fr/~maranget/papers/ml05e-maranget.pdf)
  - [When Do Match-Compilation Heuristics Matter](http://www.cs.tufts.edu/~nr/pubs/match-abstract.html) by Kevin Scott and Norman Ramsey.
  - [A Term Pattern-Match Compiler Inspired by Finite Automata Theory](https://www.classes.cs.uchicago.edu/archive/2011/spring/22620-1/papers/pettersson92.pdf), 1992, Mikael Pettersson.
    - makes checking patterns for _exhaustiveness_ and _irredundancy_ cheap.
  - [GADTs meet their match: pattern-matching warnings that account for GADTs, guards, and laziness](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/08/gadtpm-acm.pdf)
    - Paper about the new pattern-match compiler in GHC 8.
    - [ICFP talk](https://youtu.be/AFSLMTgoClI)
    - _exhaustiveness_ — Does a match cover all cases?
    - _redundancy_ — Do all equations have accessible RHSs?
    - _laziness_ — How does left-to-right evaluation order affect the above?
    - More exotic features like view-patterns and pattern-synonyms.
  - [GADTs and exhaustiveness: looking for the impossible](http://www.math.nagoya-u.ac.jp/~garrigue/papers/gadtspm.pdf). Paper about pattern-matching GADTs in OCaml.
  - [Compiling Functional Languages](http://www.cse.chalmers.se/edu/year/2011/course/CompFun/) course pages at Chalmers. Uses "The Implementation of Functional Programming Languages" by SPJ.

### Dependent pattern-matching

What about pattern-matching for dependently-typed functional languages?

How well does Idris produce warnings for redundancy and exhaustiveness?
In the face of guards? View patterns? Pattern synonyms?

What _is_ axiom K and why would you want to avoid it?


- [Pattern Matching with Dependent Types](http://strictlypositive.org/dpm/) Conor supplies some colourful slides.
- [Pattern matching without K](https://people.cs.kuleuven.be/~jesper.cockx/Without-K/Pattern-matching-without-K.pdf)
