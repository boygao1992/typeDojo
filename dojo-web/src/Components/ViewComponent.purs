module ViewComponent where

import Prelude

import CSS.Root (root) as CSSRoot
import ClassNames as CN
import HalogenUtils (classList)

import Data.Array (snoc)
import Data.DateTime.Instant (unInstant) as Time
import Data.Foldable (traverse_, foldl)
import Data.Maybe (Maybe(..))
import Data.String (length) as String
import Data.String.CodeUnits (dropRight, toCharArray) as String
import Data.Time.Duration (Milliseconds)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Now (now) as Time
import Halogen as H
import Halogen.HTML as HH
import Halogen.Query.EventSource (eventSource') as HES
import Halogen.HTML.CSS as HC
import ShowChar (showChar)
import Web.Event.Event (preventDefault) as WE
import Web.Event.EventTarget (addEventListener, eventListener, removeEventListener) as WE
import Web.HTML (HTMLDocument)
import Web.HTML (window) as DOM
import Web.HTML.HTMLDocument as HTMLDocument
import Web.HTML.Window (document) as DOM
import Web.UIEvent.KeyboardEvent (KeyboardEvent, fromEvent, key, toEvent) as KE
import Web.UIEvent.KeyboardEvent.EventTypes (keydown) as KE

-- | Effect
addOnKeyDownEventListener :: HTMLDocument -> (KE.KeyboardEvent -> Effect Unit) -> Effect (Effect Unit)
addOnKeyDownEventListener document fn = do
  let target = HTMLDocument.toEventTarget document
  listener <- WE.eventListener (traverse_ fn <<< KE.fromEvent)
  WE.addEventListener KE.keydown listener false target
  pure $ WE.removeEventListener KE.keydown listener false target

-- | Predicates
isPrint :: String -> Boolean
isPrint str
  | str == "\\" = true
  | str == " " = false
  | otherwise = String.length str == 1

isBackspace :: String -> Boolean
isBackspace = (_ == "Backspace")


-- | Types

type TimeStamp = Milliseconds

type State =
  { history :: Array KeyStroke
  , input :: String
  }

type KeyStroke =
  { key :: String
  , timeStamp :: TimeStamp
  }

initialState :: State
initialState =
  { history : []
  , input : ""
  }

data Query next
  = OnKeyDown KE.KeyboardEvent (H.SubscribeStatus -> next)
  | Init next

type Input = Unit

type Output = Void

type IO = Aff

-- | View
charBlock :: forall q. Char -> H.ComponentHTML q
charBlock char=
  HH.span [ classList [ CN.charblock]]
  [ HH.text $ showChar char]

-- | Component

render :: State -> H.ComponentHTML Query
render { input } =
  HH.div_
  [ HH.p_ $
    foldl (\acc item -> acc `snoc` (charBlock item)) [] (String.toCharArray input)
  , HC.stylesheet  CSSRoot.root
  ]

eval :: Query ~> H.ComponentDSL State Query Output IO
eval (OnKeyDown ev reply) = do
  H.liftEffect $ WE.preventDefault $ KE.toEvent ev
  ms <- Time.unInstant <$> (H.liftEffect Time.now)
  let key = KE.key $ ev
  state <- H.get
  H.modify_
    _ { history = state.history `snoc` { key : KE.key ev, timeStamp : ms} }
  when (isPrint key) do
    H.modify_ _ { input = state.input <> key }
  when (isBackspace key) do
    H.modify_ _ { input = String.dropRight 1 state.input}
  pure $ reply H.Listening
eval (Init next) = next <$ do
  document <- H.liftEffect $ DOM.document =<< DOM.window
  H.subscribe $ HES.eventSource' (addOnKeyDownEventListener document) (Just <<< H.request <<< OnKeyDown)
  pure next

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
