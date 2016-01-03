--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

import Hakyll
import Data.Monoid
import Data.Maybe
import Control.Applicative ((<$>), empty)
import qualified Data.ByteString.Lazy.Char8 as LB
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import qualified Data.Map as M
import Data.Char (toLower, isAlphaNum)
import Data.List (sortBy, isInfixOf, intercalate)
import qualified Data.ByteString.Lazy.Char8 as LB
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import qualified Data.Map as M
import Text.Jasmine

import Data.Time.Format (parseTimeM)
import Data.Time.Locale.Compat (defaultTimeLocale)
import Data.Time.Clock (UTCTime)

import System.FilePath (takeFileName)

import Text.ParserCombinators.Parsec.Char
import Text.ParserCombinators.Parsec

import Debug.Trace (trace)

import Control.Monad          (forM, forM_)
import Data.List              (sortBy, isInfixOf)
import Data.Monoid            ((<>), mconcat)
import Data.Ord               (comparing)
import Hakyll
-- import System.Locale          (defaultTimeLocale)
import System.FilePath.Posix  (
  takeBaseName,
  takeDirectory,
  (</>),
  splitFileName
  )
import YFilters (blogImage, blogFigure, frenchPunctuation, highlight)

import           Data.Monoid            ((<>),mconcat)
import           Hakyll

import           Data.List              (sortBy,isInfixOf)
import           Data.Ord               (comparing)
--import           System.Locale          (defaultTimeLocale)

import           Abbreviations          (abbreviationFilter)
import           YFilters               (blogImage,blogFigure
                                        ,frenchPunctuation,highlight)
import           Multilang              (multiContext)
import           System.FilePath.Posix  (takeBaseName,takeDirectory,(</>),splitFileName)

import           Config                 (langs,feedConfiguration)
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

  match "talks/*.md" $ do
    route $ setExtension "html"
    let ctx =  constField "title" "Talks"
            <> constField "talksactive" "active"
            <> constField "talksurl" nullLink
            <> pageCtx
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" ctx
      >>= relativizeUrls

  match "ideas/*.org" $ do
    route $ setExtension "html"
    let ctx =  constField "title" "Ideas"
            <> constField "ideasactive" "active"
            <> constField "ideasurl" nullLink
            <> pageCtx
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" ctx
      >>= relativizeUrls

  tags <- buildTags allPosts (fromCapture "tags/*.html")

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
      posts <- loadAll allPosts
      let postsCtx =  listField "posts" pageCtx (return posts)
                   <> constField "title" "Posts"
                   <> constField "description" "An archive of all my posts:"
                   <> pageCtx
      makeItem ""
        >>= loadAndApplyTemplate "templates/posts.html" postsCtx
        >>= loadAndApplyTemplate "templates/default.html" postsCtx
        >>= relativizeUrls

--  match "archive.md" $ archiveBehaviour "en"

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

  create ["drafts/index.html"] $ do
    route idRoute
    compile $ do
      drafts <- recentFirst =<< loadAll allDrafts
      let draftsCtx = listField "posts" pageCtx (return drafts)
                   <> constField "title" "Drafts"
                   <> constField "description" "Works in progress:"
                   <> pageCtx
      makeItem ""
        >>= loadAndApplyTemplate "templates/posts.html" draftsCtx
        >>= loadAndApplyTemplate "templates/default.html" draftsCtx
        >>= relativizeUrls

  create ["notes/index.html"] $ do
    route idRoute
    compile $ do
      notes <- loadAll allNotes
      let notesCtx =  listField "items" pageCtx (return notes)
                   <> constField "title" "Notes"
                   <> constField "description" ""
                   <> pageCtx
      makeItem ""
        >>= loadAndApplyTemplate "templates/listing.html" notesCtx
        >>= loadAndApplyTemplate "templates/default.html" notesCtx
        >>= relativizeUrls

  match allDrafts $ do
    route $ customRoute (floop . toFilePath)
      `composeRoutes` setExtension "html"
      `composeRoutes` customRoute (htmlToOwnDir . toFilePath)
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/post.html"    postCtx
      >>= saveSnapshot "content"

  match allNotes $ do
    route $ setExtension "html"
    let ctx =  constField "title" "Notes"
            <> constField "notesactive" "active"
            <> pageCtx
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" ctx
      >>= relativizeUrls

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

allPosts  = "posts/*"
allDrafts = "drafts/*.org"
allNotes = "notes/*.org"

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
  { feedTitle       = "Steven Shaw"
  , feedDescription = "Loves Programming Languages"
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
  , constField "talksactive"  ""
  , constField "talksurl"     "/talks"
  , constField "aboutactive"  ""
  , constField "abouturl"     "/about"
  , constField "notesactive"  ""
  , constField "notesurl"     "/notes"
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





--------------------------------------------------------------------------------
--
-- Cribbed from http://yannesposito.com/Scratch/en/blog/Hakyll-setup/
--
-- this way the url looks like: foo/bar in most browsers
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
htmlPostBehavior :: Rules ()
htmlPostBehavior = do
  route $ niceRoute
  compile $ getResourceBody
        >>= applyFilter (abbreviationFilter . frenchPunctuation . highlight)
        >>= saveSnapshot "content"
        >>= loadAndApplyTemplate "templates/post.html" yPostContext
        >>= loadAndApplyTemplate "templates/boilerplate.html" yPostContext
        >>= relativizeUrls
        >>= removeIndexHtml

--------------------------------------------------------------------------------
{-
archiveBehaviour :: String -> Rules ()
archiveBehaviour language = do
  route $ niceRoute
  compile $ do
    body <- getResourceBody
    identifier <- getUnderlying
    return $ renderPandoc (fmap (preFilters (toFilePath identifier)) body)
    >>= applyFilter postFilters
    >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
    >>= loadAndApplyTemplate "templates/default.html" archiveCtx
    >>= loadAndApplyTemplate "templates/boilerplate.html" archiveCtx
    >>= relativizeUrls
    >>= removeIndexHtml
  where
    archiveCtx =
      field "posts" (\_ -> postList language createdFirst) <>
      yContext
-}

--------------------------------------------------------------------------------
createdFirst :: [Item String] -> Compiler [Item String]
createdFirst items = do
  -- itemsWithTime is a list of couple (date,item)
  itemsWithTime <- forM items $ \item -> do
    -- getItemUTC will look for the metadata "published" or "date"
    -- then it will try to get the date from some standard formats
    utc <- getItemUTC defaultTimeLocale $ itemIdentifier item
    return (utc,item)
  -- we return a sorted item list
  return $ map snd $ reverse $ sortBy (comparing fst) itemsWithTime

--------------------------------------------------------------------------------
--
-- metaKeywordContext will return a Context containing a String
-- can be reached using $metaKeywords$ in the templates
-- Use the current item (markdown file)
-- tags contains the content of the "tags" metadata
-- inside the item (understand the source)
-- if tags is empty return an empty string
-- in the other case return
--   <meta name="keywords" content="$tags$">
--
--------------------------------------------------------------------------------
metaKeywordContext :: Context String
metaKeywordContext = field "metaKeywords" $ \item -> do
  tags <- getMetadataField (itemIdentifier item) "tags"
  return $ maybe "" showMetaTags tags
    where
      showMetaTags t = "<meta name=\"keywords\" content=\"" ++ t ++ "\">\n"

--------------------------------------------------------------------------------
--
-- load a list of Item but remove their body
--
--------------------------------------------------------------------------------
lightLoadAll :: Pattern -> Compiler [Item String]
lightLoadAll pattern = do
  identifers <- getMatches pattern
  return [Item identifier "" | identifier <- identifers]

--------------------------------------------------------------------------------
postList :: String -> ([Item String] -> Compiler [Item String]) -> Compiler String
postList language sortFilter = do
    posts   <- lightLoadAll (fromGlob $ "Scratch/" ++ language ++ "/blog/*") >>= sortFilter
    itemTpl <- loadBody "templates/post-item.html"
    list    <- applyTemplateList itemTpl yContext posts
    return list

--------------------------------------------------------------------------------
imageContext :: Context a
imageContext = field "image" $ \item -> do
  image <- getMetadataField (itemIdentifier item) "image"
  return $ maybe "/Scratch/img/presentation.png" id image


prefixContext :: Context String
prefixContext = field "webprefix" $ \_ -> return $ "/Scratch"

--------------------------------------------------------------------------------
yContext :: Context String
yContext =  constField "type" "default" <>
            metaKeywordContext <>
            shortLinkContext <>
            multiContext <>
            imageContext <>
            prefixContext <>
            defaultContext

--------------------------------------------------------------------------------
yPostContext :: Context String
yPostContext =  constField "type" "article" <>
                metaKeywordContext <>
                subtitleContext <>
                shortLinkContext <>
                multiContext <>
                imageContext <>
                prefixContext <>
                defaultContext

--------------------------------------------------------------------------------
subtitleContext :: Context String
subtitleContext = field "subtitleTitle" $ \item -> do
  subt <- getMetadataField (itemIdentifier item) "subtitle"
  return $ maybe "" showSubtitle subt
    where
      showSubtitle t = "<h2>" ++ t ++ "</h2>\n"

--------------------------------------------------------------------------------
shortLinkContext :: Context String
shortLinkContext = field "shorturl" $
                    fmap (maybe "" (removeIndexStr . toUrl)) .getRoute . itemIdentifier


--------------------------------------------------------------------------------
niceRoute :: Routes
niceRoute = customRoute createIndexRoute
  where
    createIndexRoute ident =
        takeDirectory p </> takeBaseName p </> "index.html"
      where p = toFilePath ident

--------------------------------------------------------------------------------
--
-- replace url of the form foo/bar/index.html by foo/bar
--
removeIndexHtml :: Item String -> Compiler (Item String)
removeIndexHtml item = return $ fmap (withUrls removeIndexStr) item

removeIndexStr :: String -> String
removeIndexStr url = case splitFileName url of
    (dir, "index.html") | isLocal dir -> dir
                        | otherwise   -> url
    _                                 -> url
    where isLocal uri = not (isInfixOf "://" uri)

--------------------------------------------------------------------------------
preFilters :: String -> String -> String
preFilters itemPath =   abbreviationFilter
                      . blogImage itemName
                      . blogFigure itemName
                      where
                        itemName = takeBaseName itemPath

--------------------------------------------------------------------------------
postFilters :: String -> String
postFilters = frenchPunctuation . highlight

--------------------------------------------------------------------------------
applyFilter :: (Monad m, Functor f) => (String -> String) -> f String -> m (f String)
applyFilter transformator str = return $ (fmap $ transformator) str
