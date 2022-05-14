# Docout

Docout is a multi-purpose documentation tool. Parse function docs and meta and implement one or more formatters to use the data to generate files like API specifications, onboarding guides, etc. Files will be automatically updated every time the app compiles, so you just need to save changes once.

The following were the main goals and inspiration for this library:

* Run during compilation phase (like [PhoenixSwagger](https://github.com/xerions/phoenix_swagger))
* Use native Elixir doc API (like [OpenApiSpex Controller syntax](https://github.com/open-api-spex/open_api_spex/blob/master/lib/open_api_spex/controller.ex))
* Support multiple output formats (like [Bureaucrat](https://github.com/api-hogs/bureaucrat))

## Installation

Add `{:docout, github: "tfwright/docout", branch: "main", runtime: false}` to your app's `deps`

*Note: The `runtime` option is not required, but since docout is not used at runtime it is recommended.*

## Configuration

Add the following to your app's **compile time** config (`config.exs`):

```
config :docout,
  app_name: :your_app,
  formatters: [YourFormatter]
```

Use your own formatter by creating a module that implements the `format/1` function that accepts the parsed content and returns the contents for the file to be written. You can also specify the parser if the default implementation doesn't work for your needs (see [below](#advanced-usage)): `parser: YourParser`

All formatters can be configured with `output_path` to specific the directory and name for the resulting file. By default they will be written to `/docs/[underscored module name]`

*Note: Docout itself has been configured to use the [Docout.Demo.Formatter](demo/formatter.ex) formatter to generate [docs/demo.md](docs/demo.md).*

## Minimal setup

* Add `:docout` to your app's [compiler list](https://hexdocs.pm/mix/1.12/Mix.Tasks.Compile.html#content)
* Add `docout: true` to any [module's metadata](https://hexdocs.pm/elixir/writing-documentation.html#documentation-metadata) to include its function docs in the list sent to formatters

## Advanced usage

<details>
<summary>Select which formatters should process a module</summary>

  ```
  defmodule MyModule do
    @moduledoc docout: [XFormatter, YFormatter]
  end
  ```
</details>

<details>
<summary>Customize parsing</summary>

  ```
  # mix.exs
  def YourApp.DocParser do
    def parse(mod, docs) do
      # whatever you want
    end
  end

  # config.exs

  config :docout, parser: YourApp.Parser
  ```
</details>

<details>
<summary>Only compile in specific environments</summary>

  ```
  # mix.exs
  def project do
    # ...
    compilers: Mix.compilers() ++ compilers(Mix.env())
    # ...
  end

  # ...

  defp compilers(:dev), do: true
  defp compilers(_), do: false  
  ```
</details>
