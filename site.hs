--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

import Hakyll
import Data.Monoid
import Data.Maybe
import Control.Applicative ((<$>), empty)
import qualified Data.ByteString.Lazy.Char8 as LB
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import qualified Data.Map as M
import Data.Char (toLower, isAlphaNum)
import Data.List (sortBy, intercalate)
import Control.Applicative
import qualified Data.ByteString.Lazy.Char8 as LB
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import Text.Jasmine

import Data.Time.Format (parseTimeM)
import Data.Time.Locale.Compat (defaultTimeLocale)
import Data.Time.Clock (UTCTime)

import System.FilePath (takeFileName)

import Text.ParserCombinators.Parsec.Char
import Text.ParserCombinators.Parsec

import Debug.Trace (trace)

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do

  everyPost <- getMatches allPosts
  let sortedPosts = sortIdentifiersByDate everyPost

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

  let postCtx = tagsField "tags" tags
             <> field "olderPostUrl" (olderPostUrl sortedPosts)
             <> field "newerPostUrl" (newerPostUrl sortedPosts)
             <> pageCtx

  let fixUp = map toLower . intercalate "-" . map (filter isAlphaNum) . words

  tagsRules tags $ \tag' pattern -> do
    let tag = fixUp tag'
    let title = "Posts tagged \"" ++ tag' ++ "\""
    route $ constRoute ("tags/" ++ tag ++ "/index.html")
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
    route $ customRoute (floop . toFilePath)
      `composeRoutes` setExtension "html"
      `composeRoutes` customRoute (htmlToOwnDir . toFilePath)
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

  where
    -- "posts/2015/03/29/this-is-cool.html" => "posts/2015/03/29/this-is-cool/index.html"
    htmlToOwnDir :: String -> String
    htmlToOwnDir url = either (const url) id pr
      where
        pr = runParser p 0 "<blog>" url
        p = do
          stuff <- many $ noneOf "."
          return $ stuff ++ "/index.html"
    floop :: String -> String
    floop url = either (const url) id r
      where
        r = parseResult url
    parseResult :: String -> Either ParseError String
    parseResult = runParser parsePostUrl () "<postUrl>"
    parsePostUrl :: Parser String
    parsePostUrl = do
      posts <- string "posts"
      _ <- char '/'
      year <- count 4 digit
      _ <- char '-'
      month <- count 2 digit
      _ <- char '-'
      day <- count 2 digit
      _ <- char '-'
      title <- many anyChar
      return $ intercalate "/" [posts, year, month, day, title]

compressJsCompiler :: Compiler (Item String)
compressJsCompiler = fmap jasmin <$> getResourceString

jasmin :: String -> String
jasmin src = LB.unpack $ minify $ LB.fromChunks [E.encodeUtf8 $ T.pack src]

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
  , feedAuthorEmail = "steven+feed@steshaw.org"
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

--------------------------------------------------------------------------------
-- cribbed from https://github.com/rgoulter/my-hakyll-blog/blob/master/site.hs
--------------------------------------------------------------------------------

newerPostUrl :: [Identifier] -> Item String -> Compiler String
newerPostUrl sortedPosts post = do
    let ident = itemIdentifier post
        ident' = itemBefore sortedPosts ident
    case ident' of
        Just i -> (fmap (maybe empty toUrl) . getRoute) i
        Nothing -> empty

olderPostUrl :: [Identifier] -> Item String -> Compiler String
olderPostUrl sortedPosts post = do
    let ident = itemIdentifier post
        ident' = itemAfter sortedPosts ident
    case ident' of
        Just i -> (fmap (maybe empty toUrl) . getRoute) i
        Nothing -> empty

itemAfter :: Eq a => [a] -> a -> Maybe a
itemAfter xs x =
    lookup x $ zip xs (tail xs)

itemBefore :: Eq a => [a] -> a -> Maybe a
itemBefore xs x =
    lookup x $ zip (tail xs) xs

urlOfPost :: Item String -> Compiler String
urlOfPost =
    fmap (maybe empty toUrl) . getRoute . itemIdentifier

--------------------------------------------------------------------------------
-- cribbed from https://github.com/rgoulter/my-hakyll-blog/blob/master/site.hs
--------------------------------------------------------------------------------

sortIdentifiersByDate :: [Identifier] -> [Identifier]
sortIdentifiersByDate = sortBy (flip byDate)
  where
    byDate id1 id2 =
        let fn1 = takeFileName $ toFilePath id1
            fn2 = takeFileName $ toFilePath id2
            parseTime' fn = (parseTimeM True) defaultTimeLocale "%Y-%m-%d" $ intercalate "-" $ take 3 $ splitAll "-" fn
        in compare (parseTime' fn1 :: Maybe UTCTime) (parseTime' fn2 :: Maybe UTCTime)
