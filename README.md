# Docout

Build documentation from your existing Elixir app docs at compile time.

## Installation

Add `{:docout, github: "tfwright/docout", branch: "main", runtime: false}` to your app's `deps`

*Note: The `runtime` option is not required, but since docout is not used at runtime it is recommended.*

## Configuration

Add the following to your app's **runtime** config:

```
config :docout,
  app_name: :your_app,
  formatters: [Docout.Formatters.OpenApiSpex]
```

*Note: currently only the OpenApiSpex formatter is included. Use your own formatter by creating a module that implements the `format/1` function that accepts a list of docs and returns the contents for the file to be written.*

## Usage

* Add `:docout` to your app's [compiler list](https://hexdocs.pm/mix/1.12/Mix.Tasks.Compile.html#content)
* Add `docout: true` to any [module's metadata](https://hexdocs.pm/elixir/writing-documentation.html#documentation-metadata) to include its function docs in the list sent to formatters
