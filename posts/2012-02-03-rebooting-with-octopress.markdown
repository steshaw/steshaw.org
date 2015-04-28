---
layout: post
title: "Rebooting with Octopress"
date: 2012-02-03 16:22
comments: true
categories: 
---

I'm starting with a clean slate and moving to [Octopress](http://octopress.org/).

Haskell source code highlighting appears to work out of the box:

``` haskell Run length encoding http://rosettacode.org/wiki/Run-length_encoding#Haskell
import Data.List (group)
 
-- Datatypes
type Encoded = [(Int, Char)]  -- An encoded String with form [(times, char), ...]
type Decoded = String
 
-- Takes a decoded string and returns an encoded list of tuples
rlencode :: Decoded -> Encoded
rlencode = map (\g -> (length g, head g)) . group
 
-- Takes an encoded list of tuples and returns the associated decoded String
rldecode :: Encoded -> Decoded
rldecode = concatMap decodeTuple
    where decodeTuple (n,c) = replicate n c
 
main :: IO ()
main = do
  -- Get input
  putStr "String to encode: "
  input <- getLine
  -- Output encoded and decoded versions of input
  let encoded = rlencode input
      decoded = rldecode encoded
  putStrLn $ "Encoded: " ++ show encoded ++ "\nDecoded: " ++ show decoded
```

as does Scala:

``` scala
import scala.collection.mutable

def countWords(text: String) = {
  val counts = mutable.Map[String, Int]()
  for (word <- text.split("[ ,!.]+")) {
    val lowerWord = word.toLowerCase
    val oldCount = counts.getOrElse(lowerWord, 0)
    counts(lowerWord) = oldCount + 1
  }   
  counts
}   
    
val text = "See Spot run. Run, Spot. Run!"

countWords(text) foreach println
```
