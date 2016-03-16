-- | This module defines an effect, actions and handlers for working
-- | with JavaScript exceptions.

module Control.Monad.Eff.Exception
  ( EXCEPTION
  , Error
  , error
  , message
  , stack
  , throwException
  , catchException
  , throw
  ) where

import Control.Monad.Eff (Eff)
import Control.Semigroupoid ((<<<))

import Data.Maybe (Maybe(..))
import Data.Show (class Show)

-- | This effect is used to annotate code which possibly throws exceptions
foreign import data EXCEPTION :: !

-- | The type of JavaScript errors
foreign import data Error :: *

instance showError :: Show Error where
  show = showErrorImpl

foreign import showErrorImpl :: Error -> String

-- | Create a JavaScript error, specifying a message
foreign import error :: String -> Error

-- | Get the error message from a JavaScript error
foreign import message :: Error -> String

-- | Get the stack trace from a JavaScript error
stack :: Error -> Maybe String
stack = stackImpl Just Nothing

foreign import stackImpl
  :: (forall a. a -> Maybe a)
  -> (forall a. Maybe a)
  -> Error
  -> Maybe String

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
foreign import throwException
  :: forall a eff
   . Error
  -> Eff (err :: EXCEPTION | eff) a

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
foreign import catchException
  :: forall a eff
   . (Error -> Eff eff a)
  -> Eff (err :: EXCEPTION | eff) a
  -> Eff eff a

-- | A shortcut allowing you to throw an error in one step. Defined as
-- | `throwException <<< error`.
throw :: forall eff a. String -> Eff (err :: EXCEPTION | eff) a
throw = throwException <<< error
