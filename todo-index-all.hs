#!/usr/bin/env runhaskell

import System.Directory
import System.FilePath
import Control.Monad

ignoreDirs = [".", "..", ".git", "_site", "_store", "_cache"]

getSubdirs dir = do
  contents <- getDirectoryContents dir
  subdirs <- filterM doesDirectoryExist contents
  let filtered = filter (\x -> not $ x `elem` ignoreDirs) subdirs
  return $ map (dir </>) filtered

dirsToBeIndexed = do 
  cur <- getCurrentDirectory
  subdirs <- getSubdirs cur
  subcontents <- mapM getDirectoryContents subdirs
  return $ zip subdirs subcontents

genIndex (dir, contents) = do
  putStrLn "… render template with ul"

main = do
  dirs <- dirsToBeIndexed
  dirs `forM_` (\a -> do 
    putStrLn $ show dirs
    putStrLn "---\n"
    )
