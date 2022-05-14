# Docout

Docout is a multi-purpose documentation tool. Parse function docs and meta and implement one or more formatters to use the data to generate files like API specifications, onboarding guides, etc. Files will be automatically updated every time the app compiles, so you just need to save changes once.

The following were the main goals and inspiration for this library:

* Run during compilation phase (like [PhoenixSwagger](https://github.com/xerions/phoenix_swagger))
* Use native Elixir doc API (like [OpenApiSpex Controller syntax](https://github.com/open-api-spex/open_api_spex/blob/master/lib/open_api_spex/controller.ex))
* Support multiple output formats (like [Bureaucrat](https://github.com/api-hogs/bureaucrat))

For more information about the rationale behind the project, or to contact me about the project, see https://elixirforum.com/t/docout-flexible-documentation-generator/45227

## Installation

1. Add `{:docout, github: "tfwright/docout", branch: "main", runtime: false}` to your app's `deps`

2. Add `:docout` to your app's [compiler list](https://hexdocs.pm/mix/1.12/Mix.Tasks.Compile.html#content)

## Basic usage

1. Add a module that uses Docout and implements the `format/1` function:

  ```
  defmodule MyDocFormatter do
    use Docout

    def format(_doc_list) do
      """
      My docs!
      """
    end
  ```

2. Add the following to your app's **compile time** config (`config.exs`):

  ```
  config :docout,
    app_name: :your_app,
    formatters: [MyDocFormatter]
  ```

3. Add `docout: true` to any [module's metadata](https://hexdocs.pm/elixir/writing-documentation.html#documentation-metadata) to include its function docs in the list passed to the format function.

That's it! Now when your app compiles, `Docout` will write a file with the output of your formatter to `/docs/[underscored module name]`.

*Note: Docout itself has been configured to use the [Docout.Demo.Formatter](demo/formatter.ex) formatter to generate [docs/demo.md](docs/demo.md).*

## Advanced usage

<details>
<summary>Configure where the doc file is written</summary>
  ```
  defmodule MyDocFormatter do
    use Docout, output_path: "other_dir/mydocs.html"
  end
  ```

  `output_path` should be a path relative to your app's root
</details>

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

  defp compilers(:dev), do: [:docout]
  defp compilers(_), do: []  
  ```
</details>
