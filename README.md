# Docout

Build documentation from your existing Elixir app docs at compile time.

## Installation

```elixir
def deps do
  [
    {:docout, github: "tfwright/docout", branch: "main"}
  ]
end
```

## Configuration

```
config :docout,
  app_name: :your_app,
  formatters: [Docout.Formatters.OpenApiSpex]
```

Note: currently only the OpenApiSpex formatter is included. Use your own formatter by creating a module that implements the `format/1` function that accepts a list of docs and returns the contents for the file to be written.

## Usage

* Add `:docout` to your app's [compiler list](https://hexdocs.pm/mix/1.12/Mix.Tasks.Compile.html#content).
* Add `@moduledoc docout: true` to any module to include its function docs in the list sent to formatters.
