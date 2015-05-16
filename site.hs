--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Data.Monoid
import Data.Maybe
import Control.Applicative
import qualified Data.ByteString.Lazy.Char8 as LB
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import qualified Data.Map as M
import Text.Jasmine

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do

  match "source/**" $ do
    route   $ gsubRoute "source/" (const "")
    compile copyFileCompiler

  match "css/*" $ do
    route idRoute
    compile compressCssCompiler

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

  tags <- buildTags "posts/*" (fromCapture "tags/*.html")

  let postCtx =  tagsField "tags" tags
              <> pageCtx

  tagsRules tags $ \tag pattern -> do
    let title = "Posts tagged \"" ++ tag ++ "\""
    route idRoute
    compile $ do
      posts <- recentFirst =<< loadAll pattern
      let ctx = constField "title" title 
             <> listField "posts" postCtx (return posts) 
             <> pageCtx
      makeItem "" 
        >>= loadAndApplyTemplate "templates/tag.html" ctx 
        >>= loadAndApplyTemplate "templates/default.html" ctx 
        >>= relativizeUrls
  
  match allPosts $ do
    route $ setExtension "html"
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    postCtx
      >>= saveSnapshot "content"
      >>= loadAndApplyTemplate "templates/default.html" postCtx
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
compressJsCompiler = fmap jasmin <$> getResourceString

jasmin :: String -> String
jasmin src = LB.unpack $ minify $ LB.fromChunks [(E.encodeUtf8 $ T.pack src)] 

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

subtitle :: Context a
subtitle = field "subtitle" $ \item -> do
    metadata <- getMetadata (itemIdentifier item)
    return $ fromMaybe "" $ M.lookup "subtitle" metadata

-- | Default setup is for individual post pages
pageCtx :: Context String
pageCtx = mconcat
  [ constField "homeactive" ""
  , constField "homeurl" "/"
  , constField "aboutactive"  ""
  , constField "abouturl"     "/about"
  , constField "author" "Steven Shaw"
  , dateField "date" "%e %B %Y"
  , subtitle
  , defaultContext
  ]
