module JSMiddleware where

import Prelude
import Effect (Effect)
import Node.Express.Types (Response, Request)
import Data.Function.Uncurried (Fn3)

foreign import jsonBodyParser :: Fn3 Request Response (Effect Unit) (Effect Unit)
