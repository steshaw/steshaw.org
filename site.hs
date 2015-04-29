--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Data.Monoid
import Control.Applicative

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "hm/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "economics-in-one-lesson/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "CNAME" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" myDefaultCtx
            >>= relativizeUrls

    match "about/*.md" $ do
        route $ setExtension "html"
        let ctx =  constField "title" "About"
                <> constField "aboutactive" "active"
                <> constField "abouturl" nullLink
                <> myDefaultCtx
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" ctx
            >>= relativizeUrls

    match "about/*.html" $ do
        route idRoute
        compile $ copyFileCompiler

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    create ["posts.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let postsCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Posts"               `mappend`
                    myDefaultCtx

            makeItem ""
                >>= loadAndApplyTemplate "templates/posts.html" postsCtx
                >>= loadAndApplyTemplate "templates/default.html" postsCtx
                >>= relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =  listField "posts" postCtx (return posts)
                         <> constField "title" "Home"
                         <> constField "homeactive" "active"
                         <> constField "homeurl" nullLink
                         <> myDefaultCtx

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateCompiler

    create ["atom.xml"] $ do
      route idRoute
      compile $ do
        let feedCtx = postCtx <> bodyField "description"
        posts <- feed
        renderAtom myFeedConfiguration feedCtx posts

    create ["rss.xml"] $ do
      route idRoute
      compile $ do
        let feedCtx = postCtx <> bodyField "description"
        posts <- feed
        renderAtom myFeedConfiguration feedCtx posts

      where

feed = recentFirst =<<
  loadAllSnapshots "posts/*" "content"

myFeedConfiguration = FeedConfiguration
  { feedTitle       = "Steven Shaw's Blog"
  , feedDescription = "Programming Languages and Systems"
  , feedAuthorName  = "Steven Shaw"
  , feedAuthorEmail = "steven+blog@steshaw.org"
  , feedRoot        = "http://steshaw.org"
  }

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
--    dateField "date" "%B %e, %Y" `mappend`
    myDefaultCtx

-- | Consistent convention for links that don't go anywhere
nullLink :: String
nullLink = "javascript:void(0)"

-- | Default setup is for individual post pages
myDefaultCtx :: Context String
myDefaultCtx = mconcat
      [ constField "homeactive" ""
      , constField "homeurl" "/"
      , constField "aboutactive"  ""
      , constField "abouturl"     "/about"
      , constField "author" "Steven Shaw"
      , dateField "date" "%e %B %Y"
      , defaultContext
      ]
