# Module Documentation

## Module Control.Monad.Eff.Exception

### Types

    data Exception :: * -> !


### Values

    catchException :: forall e r a. (e -> Eff r a) -> Eff (err :: Exception e | r) a -> Eff r a

    throwException :: forall a e r. e -> Eff (err :: Exception e | r) a



