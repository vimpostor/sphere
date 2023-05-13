module Match where

import Text.Regex.TDFA

import Config

matchScheme :: SchemeRules -> String -> String
matchScheme rules s = case rules of
                          (r:rs) -> if s =~ scheme r then handler r else matchScheme rs s
                          [] -> defaultHandler
