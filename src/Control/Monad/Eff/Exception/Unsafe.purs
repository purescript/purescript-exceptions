module Control.Monad.Eff.Exception.Unsafe where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Unsafe
import Control.Monad.Eff.Exception

-- | Throw an exception in pure code. This function should be used very
-- | sparingly, as it can cause unexpected crashes at runtime.
unsafeThrowException :: forall a. Error -> a
unsafeThrowException = unsafeRunEff <<< throwException
  where
  unsafeRunEff :: forall e b. Eff e b -> b
  unsafeRunEff = runPure <<< unsafeInterleaveEff

-- | Defined as `unsafeThrowException <<< error`.
unsafeThrow :: forall a. String -> a
unsafeThrow = unsafeThrowException <<< error
