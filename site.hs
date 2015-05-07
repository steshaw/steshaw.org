--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Data.Monoid
import Control.Applicative
import Text.Jasmine

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do

  match "source/**" $ do
    route   $ gsubRoute "source/" (const "")
    compile copyFileCompiler

  match "css/*" $ compile getResourceBody

  create ["css/style.css"] $ do
    route   idRoute
    compile $ do
      items <- loadAll "css/*"
      --compressCssCompiler
      makeItem $ concatMap itemBody (items :: [Item String])

  match "js/*" $ do
    route   idRoute
    compile compressJsCompiler

  match "about/*.md" $ do
    route $ setExtension "html"
    let ctx =  constField "title" "About"
            <> constField "aboutactive" "active"
            <> constField "abouturl" nullLink
            <> pageCtx
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" ctx
      >>= relativizeUrls

  match "about/*.html" $ do
    route idRoute
    compile copyFileCompiler

  match allPosts $ do
    route $ setExtension "html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    pageCtx
      >>= saveSnapshot "content"
      >>= loadAndApplyTemplate "templates/default.html" pageCtx
      >>= relativizeUrls

  create ["posts.html"] $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll allPosts
      let postsCtx =  listField "posts" pageCtx (return posts)
                   <> constField "title" "Posts"
                   <> pageCtx
      makeItem ""
        >>= loadAndApplyTemplate "templates/posts.html" postsCtx
        >>= loadAndApplyTemplate "templates/default.html" postsCtx
        >>= relativizeUrls

  match "index.html" $ do
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll allPosts
      let indexCtx =  listField "posts" pageCtx (return posts)
                   <> constField "title" "Home"
                   <> constField "homeactive" "active"
                   <> constField "homeurl" nullLink
                   <> pageCtx
      getResourceBody
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateCompiler

  let feedCtx = pageCtx <> bodyField "description"

  mkFeed "atom.xml" renderAtom
  mkFeed "rss.xml"  renderRss

compressJsCompiler :: Compiler (Item String)
compressJSCompiler = fmap jasmin <$> getResourceString

allPosts = "posts/*"

mkFeed file renderer =
  create [file] $ do
    route idRoute
    compile $ do
      let feedCtx = pageCtx <> bodyField "description"
      posts <- feed
      renderer feedConfig feedCtx posts

feed = recentFirst =<<
  loadAllSnapshots allPosts "content"

feedConfig = FeedConfiguration
  { feedTitle       = "Steven Shaw's Blog"
  , feedDescription = "Programming Languages and Systems"
  , feedAuthorName  = "Steven Shaw"
  , feedAuthorEmail = "steven+blog@steshaw.org"
  , feedRoot        = "http://steshaw.org"
  }

--------------------------------------------------------------------------------
-- | Consistent convention for links that don't go anywhere
nullLink :: String
nullLink = "javascript:void(0)"

-- | Default setup is for individual post pages
pageCtx :: Context String
pageCtx = mconcat
  [ constField "homeactive" ""
  , constField "homeurl" "/"
  , constField "aboutactive"  ""
  , constField "abouturl"     "/about"
  , constField "author" "Steven Shaw"
  , dateField "date" "%e %B %Y"
  , defaultContext
  ]
