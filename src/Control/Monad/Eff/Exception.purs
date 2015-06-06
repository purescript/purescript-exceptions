-- | This module defines an effect, actions and handlers for working
-- | with Javascript exceptions.

module Control.Monad.Eff.Exception
  ( EXCEPTION()
  , Error()
  , error
  , message
  , throwException
  , catchException
  ) where

import Prelude
import Control.Monad.Eff (Eff())

-- | This effect is used to annotate code which possibly throws exceptions
foreign import data EXCEPTION :: !

-- | The type of Javascript errors
foreign import data Error :: *

instance showError :: Show Error where
  show = showErrorImpl

foreign import showErrorImpl :: Error -> String

-- | Create a Javascript error, specifying a message
foreign import error :: String -> Error

-- | Get the error message from a Javascript error
foreign import message :: Error -> String

-- | Throw an exception
-- |
-- | For example:
-- |
-- | ```purescript
-- | main = do
-- |   x <- readNumber
-- |   when (x < 0) $ throwException $
-- |     error "Expected a non-negative number"
-- | ```
foreign import throwException :: forall a eff. Error -> Eff (err :: EXCEPTION | eff) a

-- | Catch an exception by providing an exception handler.
-- |
-- | This handler removes the `EXCEPTION` effect.
-- |
-- | For example:
-- |
-- | ```purescript
-- | main = catchException print do
-- |   trace "Exceptions thrown in this block will be logged to the console"
-- | ```
foreign import catchException :: forall a eff. (Error -> Eff eff a) -> Eff (err :: EXCEPTION | eff) a -> Eff eff a
