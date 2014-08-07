# Module Documentation

## Module Control.Monad.Eff.Exception

### Types

    data Error :: *

    data Exception :: !


### Type Class Instances

    instance showError :: Show Error


### Values

    catchException :: forall a eff. (Error -> Eff eff a) -> Eff (err :: Exception | eff) a -> Eff eff a

    error :: String -> Error

    message :: Error -> String

    showErrorImpl :: Error -> String

    throwException :: forall a eff. Error -> Eff (err :: Exception | eff) a