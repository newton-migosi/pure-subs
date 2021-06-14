let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.14.0-20210309/packages.dhall sha256:585332a8a11c6420d7287943f81bc2121746cdd352f2cf3f5ecf65053f2afcd3

in  upstream
      with css =
            { dependencies =
                  [ "effect"
                  , "these"
                  , "console"
                  , "profunctor"
                  , "nonempty"
                  , "transformers"
                  , "strings"
                  , "colors"
                  ]
            , repo =
                "https://github.com/purescript-contrib/purescript-css.git"
            , version =
                "v5.0.1"  -- branch, tag, or commit hash
            }

      with halogen-css =
            { dependencies =
                  [ "css"
                  , "halogen"
                  ]
            , repo =
                "https://github.com/purescript-halogen/purescript-halogen-css.git"
            , version =
                "v9.0.0"  -- branch, tag, or commit hash
            }