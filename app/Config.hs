module Config where

import System.Directory

data SchemeRule = SchemeRule {
    scheme :: String,
    handler :: String
} deriving Show

type SchemeRules = [SchemeRule]

data Config = Config {
    rules :: SchemeRules
} deriving Show

defaultConfig = Config {
    rules = []
}

defaultHandler = "chromium"

parseLine l = let h = reverse $ takeWhile (' '/=) $ reverse l in
                  SchemeRule {
                      scheme = reverse $ drop (1 + length h) $ reverse l,
                      handler = h
                  }

prependRule conf l = conf{rules = parseLine l : rules conf}

parse config = foldl prependRule defaultConfig $ reverse $ lines config

config = do
    file <- getXdgDirectory XdgConfig "sphere/config"
    exists <- doesFileExist file
    c <- if exists then readFile file else pure ""
    pure $ parse c
