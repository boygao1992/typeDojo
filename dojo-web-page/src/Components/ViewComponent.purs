module ViewComponent where

import Prelude

import Affjax (get, put) as AX
import Affjax.RequestBody (string) as Request
import Affjax.ResponseFormat (string) as Response
import CSS as CSS
import CSS.Root (root) as CSSRoot
import ClassNames as CN
import Data.Array (modifyAt, snoc, takeEnd, zip) as A
import Data.Either (either)
import Data.Foldable (traverse_)
import Data.FoldableWithIndex (foldlWithIndex)
import Data.Generic.Rep as Rep
import Data.Int (floor) as Int
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Newtype (unwrap)
import Data.String (length) as String
import Data.String.CodeUnits (drop, dropRight, takeRight, toCharArray) as String
import Data.Time (Time)
import Data.Time (diff) as Time
import Data.Time.Duration (Milliseconds(..))
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Now (nowTime) as Now
import Effect.Timer (setInterval, clearInterval) as Timer
import Foreign.Generic (defaultOptions, genericEncodeJSON)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.CSS as HC
import Halogen.Query.EventSource (eventSource') as HES
import HalogenUtils (classList_)
import Math as Math
import ShowChar (showChar)
import Web.Event.Event (preventDefault) as WE
import Web.Event.EventTarget (addEventListener, eventListener, removeEventListener) as WE
import Web.HTML (HTMLDocument)
import Web.HTML (window) as DOM
import Web.HTML.HTMLDocument as HTMLDocument
import Web.HTML.Window (Window)
import Web.HTML.Window (document, requestAnimationFrame) as DOM
import Web.UIEvent.KeyboardEvent (KeyboardEvent, fromEvent, key, toEvent) as KE
import Web.UIEvent.KeyboardEvent.EventTypes (keydown) as KE

-- | Utils
interval :: Maybe Time -> Maybe Time -> Milliseconds
interval initTime currentTime =
  fromMaybe mempty $ (Time.diff) <$> currentTime <*> initTime

modifyAt :: forall a. Int -> (a -> a) -> Array a -> Array a
modifyAt n f arr = fromMaybe arr $ A.modifyAt n f arr

-- | Effect
addOnKeyDownEventListener :: HTMLDocument -> (KE.KeyboardEvent -> Effect Unit) -> Effect (Effect Unit)
addOnKeyDownEventListener document fn = do
  let target = HTMLDocument.toEventTarget document
  listener <- WE.eventListener (traverse_ fn <<< KE.fromEvent)
  WE.addEventListener KE.keydown listener false target
  pure $ WE.removeEventListener KE.keydown listener false target

addTimer :: Window -> (Time -> Effect Unit) -> Effect (Effect Unit)
addTimer window fn = do
  id <- Timer.setInterval 50 do
    void $ DOM.requestAnimationFrame (fn =<< Now.nowTime) window
  pure $ Timer.clearInterval id

-- | Predicates
isPrint :: String -> Boolean
isPrint str
  | str == "\\" = true
  | str == " " = false
  | otherwise = String.length str == 1

isBackspace :: String -> Boolean
isBackspace = (_ == "Backspace")

isInsert :: String -> Boolean
isInsert = (_ == "Insert")

isLeft :: String -> Boolean
isLeft = (_ == "ArrowLeft")

isRight :: String -> Boolean
isRight = (_ == "ArrowRight")

isSpace :: String -> Boolean
isSpace = (_ == " ")

isEnter :: String -> Boolean
isEnter = (_ == "Enter")

-- TODO isDojoCompleted :: Array DojoChar -> Boolean

-- | Types

type TimeStamp = Time

-- TODO: use purescript-formatters
viewTimer :: Milliseconds -> String
viewTimer (Milliseconds ms) =
  let
    minuteLength = 60000.0
    secondLength = 1000.0
    minutes = Math.floor (ms / minuteLength)
    seconds = Math.floor ((ms - (minutes * minuteLength)) / secondLength)
    milliseconds = ms - (minutes * minuteLength + seconds * secondLength)
  in
       (show <<< Int.floor $ minutes)
    <> " : "
    <> (String.takeRight 2 <<< ("0" <> _) <<< show <<< Int.floor $ seconds)
    <> " : "
    <> (String.takeRight 3 <<< ("00" <> _)<<< show <<< Int.floor $ milliseconds)

-- TODO merge input into dojo
type State =
  { history :: Array KeyStroke
  , input :: String
  , dojo :: String -- Array DojoChar
  , cursor :: Int
  , status :: Status
  , initTime :: Maybe Time
  , currentTime :: Maybe Time
  , duration :: Milliseconds
  }

newtype Session = Session
  { input :: String
  , dojo :: String
  , duration :: Number
  }
derive instance repGenericSession :: Rep.Generic Session _

data Status
  = Stopped
  | Playing
  | Paused
derive instance eqStatus :: Eq Status
instance showStatus :: Show Status where
  show Stopped = "Stopped"
  show Playing = "Playing"
  show Paused = "Paused"

type KeyStroke =
  { key :: String
  , timeStamp :: TimeStamp
  , status :: Status
  }

-- TODO
-- type DojoChar =
--   { char :: Char
--   , status :: KeyMatch
--   }

data KeyMatch
  = KeyCorrect
  | KeyWrong Char
  | KeyNoInput
derive instance eqKeyMatch :: Eq KeyMatch
instance showKeyMatch :: Show KeyMatch where
  show KeyCorrect = "KeyCorrect"
  show (KeyWrong c) = "KeyWrong: " <> show c
  show KeyNoInput = "KeyNoInput"

type KeyProcessed =
  { key :: Char
  , status :: KeyMatch
  }

initialState :: State
initialState =
  { history : []
  , input : ""
  , dojo : "123"
  , cursor : 0
  , status : Stopped
  , initTime : Nothing
  , currentTime : Nothing
  , duration : mempty
  }

data Query next
  = Init next
  | OnKeyDown KE.KeyboardEvent (H.SubscribeStatus -> next)
  | Tick Time (H.SubscribeStatus -> next)

type Input = Unit

type Output = Void

type IO = Aff

-- | View
charBlock :: forall q. Boolean -> KeyProcessed -> H.ComponentHTML q
charBlock isCursor { key, status } =
  HH.span [ classList_
            $ [ Tuple true CN.charblock
              , Tuple isCursor CN.cursor
              ]
              `A.snoc`
              ( case status of
                  KeyCorrect -> Tuple true CN.keyCorrect
                  KeyWrong _ -> Tuple true CN.keyWrong
                  KeyNoInput -> Tuple false ""
              )
          ]
  [ HH.text $ showChar key]

-- | Component

render :: State -> H.ComponentHTML Query
render { input , dojo , cursor, status, initTime, currentTime, duration} =
  HH.div_
  [ HH.p_
    [ HH.text $ viewTimer $ duration <> interval initTime currentTime ]
  , HH.p_ $
    foldlWithIndex (\idx acc item -> acc `A.snoc` (charBlock (cursor == idx) item)) [] processed
  , HH.p [ HC.style do
              CSS.display CSS.displayNone
              -- TODO when (isDojoCompleted dojo) do
              when (String.length input == String.length dojo) do
                CSS.display CSS.block
         ]
    [ HH.text $ "Enter to submit"]
  , HH.p_
    [ HH.text $ "cursor: " <> show cursor]
  , HH.p_
    [ HH.text $ "status: " <> show status]
  , HC.stylesheet  CSSRoot.root
  ]

  where
    _input :: Array Char
    _input = String.toCharArray input

    _dojo :: Array Char
    _dojo = String.toCharArray dojo

    processed :: Array KeyProcessed
    processed =
      (_ <>
       ( (\d -> { key : d, status : KeyNoInput })
         <$> A.takeEnd (String.length dojo - String.length input) _dojo)
      )
      $ (\(Tuple i d) ->
          if i == d
          then { key : d , status : KeyCorrect }
          else { key : d , status : KeyWrong i }
        )
      <$> A.zip _input _dojo

eval :: Query ~> H.ComponentDSL State Query Output IO
eval (Init next) = next <$ do
  window <- H.liftEffect DOM.window
  document <- H.liftEffect $ DOM.document window
  H.subscribe $ HES.eventSource' (addOnKeyDownEventListener document) (Just <<< H.request <<< OnKeyDown)

  { body } <- H.liftAff $ AX.get Response.string url
  let dojo = String.dropRight 1
              <<< String.drop 1
              <<< either (const "") identity
                $ body
  H.modify_ _ { dojo = dojo }

  where
    url :: String
    url = "/dojo"

eval (OnKeyDown ev reply) = do
  let key = KE.key $ ev
  when (not <<< isInsert $ key) do
    H.liftEffect <<< WE.preventDefault <<< KE.toEvent $ ev

  currentTime <- H.liftEffect Now.nowTime

  state <- H.get
  H.modify_
    _ { history = state.history
          `A.snoc` { key : KE.key ev
                   , timeStamp : currentTime
                   , status : state.status
                   }
      }

  when (isEnter key
        && state.status == Playing
        && (String.length state.input == String.length state.dojo)
       ) do
    let duration = state.duration <> interval state.initTime (Just currentTime)
    H.modify_
      _ { status = Stopped
        , initTime = Just currentTime
        , currentTime = Just currentTime
        , duration = duration
        }
    -- TODO: response validation
    void $ H.liftAff
         $ AX.put
            Response.string
            recordDojoUrl
            ( Request.string
            <<< genericEncodeJSON
                  (defaultOptions { unwrapSingleConstructors = true })
              $ (Session
                  { input : state.input
                  , dojo: state.dojo
                  , duration : unwrap duration
                  }
              )
            )


  when (isPrint key) do
    when (String.length state.input < String.length state.dojo) do
      H.modify_ _ { input = state.input <> key }

    case state.status of
      Stopped -> do
        H.modify_
          _ { status = Playing
            , initTime = Just currentTime
            , currentTime = Just currentTime
            , duration = mempty :: Milliseconds
            }
        startTimer

      Paused -> do
        H.modify_
          _ { status = Playing
            , initTime = Just currentTime
            , currentTime = Just currentTime
            }
        startTimer

      Playing -> pure unit

  when (isBackspace key) do
    H.modify_ _ { input = String.dropRight 1 state.input}

  when ((isLeft key) && (state.cursor > 0)) do
    H.modify_ _ { cursor = state.cursor - 1 }

  when ((isRight key) && (state.cursor < String.length state.dojo - 1)) do
    H.modify_ _ { cursor = state.cursor + 1 }

  when (isSpace key)
    case state.status of
      Stopped -> do
        H.modify_
          _ { status = Playing
            , initTime = Just currentTime
            , currentTime = Just currentTime
            , duration = mempty :: Milliseconds
            }
        startTimer

      Paused -> do
        H.modify_
          _ { status = Playing
            , initTime = Just currentTime
            , currentTime = Just currentTime
            }
        startTimer

      Playing -> do
        H.modify_ \st ->
          st { status = Paused
             , initTime = Just currentTime
             , currentTime = Just currentTime
             , duration = state.duration
                          <> interval state.initTime (Just currentTime)
             }

  pure $ reply H.Listening

  where
    recordDojoUrl :: String
    recordDojoUrl = "/dojo/record"

    startTimer :: H.ComponentDSL State Query Output IO Unit
    startTimer = do
      window <- H.liftEffect DOM.window
      H.subscribe $ HES.eventSource' (addTimer window) (Just <<< H.request <<< Tick)

eval (Tick currentTime reply) = do
  status <- H.gets _.status
  case status of
    Stopped -> pure $ reply H.Done
    Paused ->  pure $ reply H.Done
    Playing -> do
      H.modify_ _ { currentTime = Just currentTime }
      pure $ reply H.Listening



component :: H.Component HH.HTML Query Input Output IO
component = H.lifecycleComponent spec'
  where
    spec' :: H.LifecycleComponentSpec HH.HTML State Query Input Output IO
    spec' =
      { initialState : const initialState
      , render
      , eval
      , initializer : Just (H.action Init)
      , finalizer : Nothing
      , receiver : const Nothing
      }
