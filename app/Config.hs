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

parseLine :: String -> SchemeRule
parseLine l = let h = reverse $ takeWhile (' '/=) $ reverse l in
                  SchemeRule {
                      scheme = reverse $ drop (1 + length h) $ reverse l,
                      handler = h
                  }

prependRule :: Config -> String -> Config
prependRule conf l = conf{rules = parseLine l : rules conf}

parse :: String -> Config
parse config = foldl prependRule defaultConfig $ reverse $ lines config

config :: IO Config
config = do
    file <- getXdgDirectory XdgConfig "sphere/config"
    exists <- doesFileExist file
    c <- if exists then readFile file else pure ""
    pure $ parse c
