module ViewComponent where

import Prelude

import Affjax (get) as AX
import Affjax.ResponseFormat (string) as AX
import CSS.Root (root) as CSSRoot
import ClassNames as CN
import Data.Array (snoc, takeEnd, zip) as A
import Data.DateTime.Instant (unInstant) as Time
import Data.Either (either)
import Data.Foldable (traverse_)
import Data.FoldableWithIndex (foldlWithIndex)
import Data.Int (floor) as Int
import Data.Maybe (Maybe(..))
import Data.String (length) as String
import Data.String.CodeUnits (dropRight, takeRight, toCharArray) as String
import Data.Time.Duration (Milliseconds(..))
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Now (now) as Time
import Effect.Timer (setInterval, clearInterval) as Timer
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

-- | Effect
addOnKeyDownEventListener :: HTMLDocument -> (KE.KeyboardEvent -> Effect Unit) -> Effect (Effect Unit)
addOnKeyDownEventListener document fn = do
  let target = HTMLDocument.toEventTarget document
  listener <- WE.eventListener (traverse_ fn <<< KE.fromEvent)
  WE.addEventListener KE.keydown listener false target
  pure $ WE.removeEventListener KE.keydown listener false target

addTimer :: Window -> (Milliseconds -> Effect Unit) -> Effect (Effect Unit)
addTimer window fn = do
  id <- Timer.setInterval 50 do
    _ <- DOM.requestAnimationFrame (fn =<< Time.unInstant <$> Time.now) window
    pure unit
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

-- | Types

type TimeStamp = Milliseconds

subMilli :: Milliseconds -> Milliseconds -> Milliseconds
subMilli (Milliseconds x) (Milliseconds y) = Milliseconds $ x - y

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

type State =
  { history :: Array KeyStroke
  , input :: String
  , dojo :: String
  , cursor :: Int
  , status :: Status
  , initTime :: Milliseconds
  , currentTime :: Milliseconds
  , duration :: Milliseconds
  }

data Status
  = Stopped
  | Playing
  | Paused
instance showStatus :: Show Status where
  show Stopped = "Stopped"
  show Playing = "Playing"
  show Paused = "Paused"

type KeyStroke =
  { key :: String
  , timeStamp :: TimeStamp
  }

data KeyMatch
  = KeyCorrect
  | KeyWrong
  | KeyNoInput
derive instance eqKeyMatch :: Eq KeyMatch
instance showKeyMatch :: Show KeyMatch where
  show KeyCorrect = "KeyCorrect"
  show KeyWrong = "KeyWrong"
  show KeyNoInput = "KeyNoInput"

type KeyProcessed =
  { key :: Char
  , status :: KeyMatch
  }

initialState :: State
initialState =
  { history : []
  , input : ""
  , dojo : "\".zww?]M#=uh9F:%^qqE(W(=$D*x\"Kw7'@h+\\ELI{v?N\\$ySJ<i%\"jE.W@}u7An5:%q%{)_[_OEu#b(BxM=A$\\;25tR):dvM,:4r7&/D.X#Du_?1~F+I6Mvy(u>)]oir,YM)K5LoMQ~]#\\(kl8IO+Iv87c==;bx}Dwqa}YM4yC5/2*?%L,;_mix>ca?9%'BT4O<b!{irs]zH%mgE]wb#CM9DK{!^OH;sh&$/.E<I}].[ZDoiO6V9*p\\U@[N9\\G@.=ccW+>uc7<D<qE*rMV^^*_JZdLdP!EFTP)fnyn2gP1C\""
  , cursor : 0
  , status : Stopped
  , initTime : mempty
  , currentTime : mempty
  , duration : mempty
  }

data Query next
  = Init next
  | OnKeyDown KE.KeyboardEvent (H.SubscribeStatus -> next)
  | Tick Milliseconds (H.SubscribeStatus -> next)

type Input = Unit

type Output = Void

type IO = Aff

-- | View
charBlock :: forall q. Boolean -> KeyProcessed -> H.ComponentHTML q
charBlock isCursor { key, status } =
  HH.span [ classList_ [ Tuple true CN.charblock
                       , Tuple (status == KeyCorrect) CN.keyCorrect
                       , Tuple (status == KeyWrong) CN.keyWrong
                       , Tuple isCursor CN.cursor
                       ]
          ]
  [ HH.text $ showChar key]



-- | Component

render :: State -> H.ComponentHTML Query
render { input , dojo , cursor, status, initTime, currentTime, duration} =
  HH.div_
  [ HH.p_
    [ HH.text $ viewTimer $ duration <> currentTime `subMilli` initTime ]
  , HH.p_ $
    foldlWithIndex (\idx acc item -> acc `A.snoc` (charBlock (cursor == idx) item)) [] processed
  , HH.p_
    [ HH.text $ "input: " <> show input]
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
      $ (\(Tuple i d) -> if i == d then { key : d , status : KeyCorrect } else { key : d , status : KeyWrong })
      <$> A.zip _input _dojo

eval :: Query ~> H.ComponentDSL State Query Output IO
eval (Init next) = next <$ do
  window <- H.liftEffect DOM.window
  document <- H.liftEffect $ DOM.document window
  H.subscribe $ HES.eventSource' (addOnKeyDownEventListener document) (Just <<< H.request <<< OnKeyDown)

  { body } <- H.liftAff $ AX.get AX.string url
  let dojo = either (const "") identity body
  H.modify_ _ { dojo = dojo }

  where
    url :: String
    url = "/dojo"

eval (OnKeyDown ev reply) = do
  let key = KE.key $ ev
  when (not <<< isInsert $ key) do
    H.liftEffect $ WE.preventDefault $ KE.toEvent ev

  currentTime <- Time.unInstant <$> (H.liftEffect Time.now)
  state <- H.get
  H.modify_
    _ { history = state.history `A.snoc` { key : KE.key ev, timeStamp : currentTime} }

  when (isPrint key) do
    H.modify_ _ { input = state.input <> key }

  when (isBackspace key) do
    H.modify_ _ { input = String.dropRight 1 state.input}

  when (isLeft key) do
    when (state.cursor > 0) do
      H.modify_ _ { cursor = state.cursor - 1 }

  when (isRight key) do
    when (state.cursor < String.length state.dojo - 1) do
      H.modify_ _ { cursor = state.cursor + 1 }

  when (isSpace key)
    case state.status of
      Stopped -> do
        H.modify_ _ { status = Playing
                    , initTime = currentTime
                    , duration = mempty :: Milliseconds
                    }
        window <- H.liftEffect DOM.window
        H.subscribe $ HES.eventSource' (addTimer window) (Just <<< H.request <<< Tick)
        pure unit
      Paused -> do
        H.modify_ _ { status = Playing , initTime = currentTime }
        window <- H.liftEffect DOM.window
        H.subscribe $ HES.eventSource' (addTimer window) (Just <<< H.request <<< Tick)
        pure unit
      Playing -> do
        H.modify_ \st ->
          st { status = Paused
                , initTime = currentTime
                , duration = st.duration <> currentTime `subMilli` st.initTime
                }
        H.modify_ _ { status = Paused }
        pure unit

  pure $ reply H.Listening
eval (Tick ms reply) = do
  status <- H.gets _.status
  case status of
    Stopped -> pure $ reply H.Done
    Paused ->  pure $ reply H.Done
    Playing -> do
      H.modify_ _ { currentTime = ms }
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
