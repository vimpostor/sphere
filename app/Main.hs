module Main where

import Data.List
import System.Environment
import System.Process

import Config
import Match

main :: IO ()
main = do
    config <- Config.config
    args <- getArgs
    let uri = intercalate " " args
    let handler = matchScheme (rules config) uri
    callProcess handler args
