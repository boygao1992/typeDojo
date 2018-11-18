module Effects where

import Prelude

import Data.Array (index) as A
import Data.Formatter.DateTime (Formatter, FormatterCommand(..), format)
import Data.List (fromFoldable) as List
import Data.Maybe (fromMaybe)
import Data.String.CodeUnits (fromCharArray)
import Effect (Effect)
import Effect.Now (nowDateTime)
import Effect.Ref (read, modify_) as Ref
import Node.Encoding (Encoding(UTF8))
import Node.FS.Sync (writeTextFile, exists, mkdir) as FS
import Random.PseudoRandom.WithSeed (randomRsWithSeed)
import Types (StateRef, charSet, charSetSize)

-- genRandomChar :: Effect Char
-- genRandomChar = do
--   num <- Random.randomInt 0 (charSetSize - 1)
--   pure $ fromMaybe ' ' <<< A.index charSet $ num

-- genRandomChars :: Int -> Effect (Array Char)
-- genRandomChars n
--   | n < 1 = pure []
--   | otherwise = traverse (const genRandomChar) (A.replicate n unit)

-- genRandomString :: Int -> Effect String
-- genRandomString = map fromCharArray <<< genRandomChars

genRandomDojo :: StateRef -> Int -> Effect String
genRandomDojo stateRef n = do
  state <- Ref.read stateRef
  let result = randomRsWithSeed 0 (charSetSize - 1) n state.seed
  Ref.modify_ _ { seed = result.seed } stateRef
  pure
    <<< fromCharArray
    <<< map (fromMaybe ' ' <<< A.index charSet)
      $ result.values


genFileName :: Effect String
genFileName = do
  dateTime <- nowDateTime
  pure $ format formatter dateTime

  where
    formatter :: Formatter
    formatter = List.fromFoldable
      [ YearFull
      , Placeholder "-"
      , MonthTwoDigits
      , Placeholder "-"
      , DayOfMonthTwoDigits
      , Placeholder "T"
      , Hours24
      , Placeholder ":"
      , MinutesTwoDigits
      , Placeholder ":"
      , SecondsTwoDigits
      ]

persistDojoSession :: String  -> Effect Unit
persistDojoSession session = do
  filename <- genFileName
  doesExist <- FS.exists dir
  when (not doesExist) do
    FS.mkdir dir
  FS.writeTextFile UTF8 (dir <> filename <> ".json") session

  where
    dir :: String
    dir = "./record/"
