{ name = "halogen-project"
, dependencies = [ "console", "effect", "halogen", "psci-support", "prelude" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
