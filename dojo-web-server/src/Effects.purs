module Effects where

import Prelude

import Data.String.CodeUnits (fromCharArray)
import Data.Array (index, replicate) as A
import Data.Maybe (fromMaybe)
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Random (randomInt) as Random
import Types (charSet, charSetSize)

genRandomChar :: Effect Char
genRandomChar = do
  num <- Random.randomInt 0 (charSetSize - 1)
  pure $ fromMaybe ' ' <<< A.index charSet $ num

genRandomChars :: Int -> Effect (Array Char)
genRandomChars n
  | n < 1 = pure []
  | otherwise = traverse (const genRandomChar) (A.replicate n unit)

genRandomString :: Int -> Effect String
genRandomString = map fromCharArray <<< genRandomChars
