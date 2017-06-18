# Parsing

## Libraries

- [Parsec](http://www.haskell.org/haskellwiki/Parsec)
- [attoparsec](https://github.com/bos/attoparsec)
- [polyparse](http://hackage.haskell.org/package/polyparse)
- [uu-parsing-lib](http://hackage.haskell.org/package/uu-parsinglib)
- [trifecta](https://github.com/ekmett/trifecta/)
- [Megaparsec](https://github.com/mrkkrp/megaparsec)

## Attoparsec

- [What's in a parsing library](http://www.serpentine.com/blog/2010/03/03/whats-in-a-parsing-library-1/)
  - Parsec has an appealing API.
  - Parsec 3 is slower than Parsec 2.
  - Parsec's API demands that all of a parser's input be available at once.
- [What's in a parser? Attoparsec rewired](http://www.serpentine.com/blog/2010/03/03/whats-in-a-parser-attoparsec-rewired-2/)
- [A major upgrade to attoparsec: more speed, more power](http://www.serpentine.com/blog/2014/05/31/attoparsec/)
  - 3rd generation attoparsec is much faster.
  - 0.11 -> 0.12
  - Up to x2 on micro-benchmarks.
  - Uses buffers and cursors (index into buffer).
    - Uses unsafe tricks to grow the buffer.
    - Remains resilent to programmer misuse via a "generation" tag.

## Megaparsec

- [The original Megaparsec 4.0.0 announcement](https://notehub.org/w7037)
- [Megaparsec 4 and 5](https://markkarpov.com/post/megaparsec-4-and-5.html)
- [Announcing Megaparsec 5](https://markkarpov.com/post/announcing-megaparsec-5.html)
- [Latest additions to Megaparsec](https://markkarpov.com/post/latest-additions-to-megaparsec.html)
- [Metaparsec tutorials](https://markkarpov.com/learn-haskell.html#megaparsec-tutorials)

## Other articles

- [Parsec: "try a <|> b" considered harmful](http://blog.ezyang.com/2014/05/parsec-try-a-or-b-considered-harmful/)

## Papers

- [How to replace failure by a list of successes — A method for exception handling, backtracking, and pattern matching in lazy functional languages](https://rkrishnan.org/files/wadler-1985.pdf), 1985
- [Monadic Parser Combinators](http://www.cs.nott.ac.uk/~pszgmh/monparsing.pdf), 1996
- [Monadic Parsing in Haskell (Functional Pearl)](http://www.cs.nott.ac.uk/~pszgmh/pearl.pdf), 1998
- [Parsec: Direct Style Monadic Parser Combinators for the Real World](https://www.microsoft.com/en-us/research/publication/parsec-direct-style-monadic-parser-combinators-for-the-real-world/), 2001
- [Combinator Parsing: A Short Tutorial](http://www.cs.uu.nl/research/techreps/repo/CS-2008/2008-044.pdf), 2008. The genesis of `uu-parsinglib`.
