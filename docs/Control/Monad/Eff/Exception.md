## Module Control.Monad.Eff.Exception

This module defines an effect, actions and handlers for working
with JavaScript exceptions.

#### `EXCEPTION`

``` purescript
data EXCEPTION :: !
```

This effect is used to annotate code which possibly throws exceptions

#### `Error`

``` purescript
data Error :: *
```

The type of JavaScript errors

##### Instances
``` purescript
Show Error
```

#### `error`

``` purescript
error :: String -> Error
```

Create a JavaScript error, specifying a message

#### `message`

``` purescript
message :: Error -> String
```

Get the error message from a JavaScript error

#### `stack`

``` purescript
stack :: Error -> Maybe String
```

Get the stack trace from a JavaScript error

#### `throwException`

``` purescript
throwException :: forall a eff. Error -> Eff (err :: EXCEPTION | eff) a
```

Throw an exception

For example:

```purescript
main = do
  x <- readNumber
  when (x < 0) $ throwException $
    error "Expected a non-negative number"
```

#### `catchException`

``` purescript
catchException :: forall a eff. (Error -> Eff eff a) -> Eff (err :: EXCEPTION | eff) a -> Eff eff a
```

Catch an exception by providing an exception handler.

This handler removes the `EXCEPTION` effect.

For example:

```purescript
main = catchException print do
  trace "Exceptions thrown in this block will be logged to the console"
```

#### `throw`

``` purescript
throw :: forall eff a. String -> Eff (err :: EXCEPTION | eff) a
```

A shortcut allowing you to throw an error in one step. Defined as
`throwException <<< error`.


