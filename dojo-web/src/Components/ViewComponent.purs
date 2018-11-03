module ViewComponent where

import Prelude

import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
-- import Halogen.HTML.CSS as HC
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
-- import HalogenUtils (classList, classList_)
import Web.UIEvent.KeyboardEvent as KE
import Data.Time.Duration (Milliseconds)
import Data.DateTime.Instant (unInstant)
import Effect.Now (now)
import Data.Array (snoc)
import Effect.Aff (Aff)

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
  = OnKeyDown KE.KeyboardEvent next
  | OnInput String next

type Input = Unit

type Output = Void

type IO = Aff

-- | View

-- | Component

render :: State -> H.ComponentHTML Query
render state =
  HH.div_
  [ HH.input [ HE.onKeyDown $ HE.input OnKeyDown
             , HE.onValueInput $ HE.input OnInput
             , HP.value $ state.input
             ]
  , HH.p_
    [ HH.text $ show $ state]
  ]


eval :: Query ~> H.ComponentDSL State Query Output IO
eval (OnKeyDown ev next) = next <$ do
  ms <- unInstant <$> (H.liftEffect now)
  history <- H.gets _.history
  H.modify _ { history = history `snoc` { key : KE.key ev, timeStamp : ms} }
eval (OnInput input next) = next <$ do
  H.modify_ _ { input = input}

component :: H.Component HH.HTML Query Input Output IO
component = H.component spec
  where
    spec :: H.ComponentSpec HH.HTML State Query Input Output IO
    spec =
      { initialState : const initialState
      , render
      , eval
      , receiver : const Nothing
      }
