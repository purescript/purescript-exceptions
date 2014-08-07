module Control.Monad.Eff.Exception where

import Control.Monad.Eff

foreign import data Exception :: !

foreign import data Error :: *

instance showError :: Show Error where
  show = showErrorImpl

foreign import showErrorImpl
  "function showErrorImpl(err) {\
  \  return err.stack ? err.stack : err.toString();\
  \}" :: Error -> String

foreign import error
  "function error(msg) {\
  \  return new Error(msg);\
  \};" :: String -> Error

foreign import message 
  "function message(e) {\
  \  return e.message;\
  \}" :: Error -> String
  
foreign import throwException 
  "function throwException(e) {\
  \  return function() {\
  \    throw e;\
  \  };\
  \}" :: forall a eff. Error -> Eff (err :: Exception | eff) a

foreign import catchException 
  "function catchException(c) {\
  \  return function(t) {\
  \    return function() {\
  \      try {\
  \        return t();\
  \      } catch(e) {\
  \        if (e instanceof Error) {\
  \          return c(e)();\
  \        } else {\
  \          throw e;\
  \        }\
  \      }\
  \    };\
  \  };\
  \}" :: forall a eff. (Error -> Eff eff a) -> Eff (err :: Exception | eff) a -> Eff eff a
