{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.List ( stripPrefix )
import Control.Monad ( unless )
import Safe ( headMay )
import System.Environment ( getArgs )
import System.Directory ( getCurrentDirectory, getHomeDirectory )
import Unison.Codebase.Serialization.V0 ( formatSymbol )
import Unison.Parser ( Ann(External) )
import qualified Unison.Codebase2 as Codebase
import qualified Unison.Codebase.FileCodebase2 as FileCodebase
import qualified Unison.Codebase.Serialization as S
import qualified Unison.CommandLine.Main2 as CommandLine
import qualified Unison.Runtime.Rt1IO as Rt1
import qualified Unison.Codebase.Path as Path

main :: IO ()
main = do
  args <- getArgs
  -- hSetBuffering stdout NoBuffering -- cool
  dir  <- getCurrentDirectory
  home <- getHomeDirectory
  let codebasePath    = ".unison/v0"
      initialPath     = Path.absoluteEmpty
      scratchFilePath = case stripPrefix home dir of
        Just d  -> "~" <> d
        Nothing -> dir
      theCodebase =
        FileCodebase.codebase1 External formatSymbol formatAnn codebasePath
      launch = CommandLine.main scratchFilePath
                                initialPath
                                (headMay args)
                                (pure Rt1.runtime)
                                theCodebase
  exists <- FileCodebase.exists codebasePath
  unless exists $ do
    putStrLn
      $  "☝️  No codebase exists here so I'm initializing one in: "
      <> codebasePath
    FileCodebase.initialize codebasePath
    Codebase.initializeCodebase theCodebase
  launch

formatAnn :: S.Format Ann
formatAnn = S.Format (pure External) (\_ -> pure ())
