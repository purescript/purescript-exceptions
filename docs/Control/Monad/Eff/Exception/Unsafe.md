## Module Control.Monad.Eff.Exception.Unsafe

#### `unsafeThrowException`

``` purescript
unsafeThrowException :: forall a. Error -> a
```

Throw an exception in pure code. This function should be used very
sparingly, as it can cause unexpected crashes at runtime.

#### `unsafeThrow`

``` purescript
unsafeThrow :: forall a. String -> a
```

Defined as `unsafeThrowException <<< error`.


