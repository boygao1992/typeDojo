module Types where

import Data.Array (length) as A

-- | Data Model

-- 1234567890-=\`
-- !@#$%^&*()_+|~
-- qwertyuiop[]
-- QWERTYUIOP{}
-- asdfghjkl;'
-- ASDFGHJKL:"
-- zxcvbnm,./
-- ZXCVBNM<>?
charSet :: Array Char
charSet =
  [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '\\'
  , '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '~'
  , 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']'
  , 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}'
  , 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\''
  , 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"'
  , 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/'
  , 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?'
  , ' '
  ]

charSetSize :: Int
charSetSize = A.length charSet

type State =
  { dojo :: Array Char
  }

initialState :: State
initialState =
  { dojo : []
  }
