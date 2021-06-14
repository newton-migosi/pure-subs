{ name = "halogen-project"
, dependencies =
  [ "console"
  , "dom-filereader"
  , "effect"
  , "halogen"
  , "prelude"
  , "psci-support"
  , "aff"
  , "dom-indexed"
  , "foldable-traversable"
  , "maybe"
  , "media-types"
  , "web-events"
  , "web-file"
  , "web-html"
  , "web-uievents"
  , "css"
  , "halogen-css"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
