# Module Documentation

## Module Control.Monad.Eff.Exception

### Types

    type Error  = { stack :: String, message :: String }

    data Exception :: !


### Values

    catchException :: forall a eff. (Error -> Eff eff a) -> Eff (err :: Exception | eff) a -> Eff eff a

    throwException :: forall a eff. Error -> Eff (err :: Exception | eff) a