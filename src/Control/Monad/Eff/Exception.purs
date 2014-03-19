module Control.Monad.Eff.Exception where

import Control.Monad.Eff

foreign import data Exception :: * -> !

foreign import throwException 
  "function throwException(e) {\
  \  return function() {\
  \    throw e;\
  \  };\
  \}" :: forall a e r. e -> Eff (err :: Exception e | r) a

foreign import catchException 
  "function catchException(c) {\
  \  return function(t) {\
  \    return function() {\
  \      try {\
  \        return t();\
  \      } catch(e) {\
  \        return c(e)();\
  \      }\
  \    };\
  \  };\
  \}" :: forall e r a. (e -> Eff r a) -> Eff (err :: Exception e | r) a -> Eff r a
