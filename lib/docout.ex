defmodule Docout do
  @moduledoc """
    Use this module in another module to mark it for doc formatting.

    Docs for all functions in the module will be passed to configured formatters for processing.

    defmodule SomeModule do
      use Docout

      @doc "these docs will be passed to formatter"
      @doc meta: "this too"
      def some_func, do: :ok
    end
  """

  defmacro __using__(opts) do
    quote do
      Module.register_attribute(__MODULE__, :_docout_config, persist: true)
      Module.put_attribute(__MODULE__, :_docout_config, unquote(opts))
    end
  end

  def process(modules) do
    docs =
      modules
      |> Enum.flat_map(fn mod ->
        mod.__info__(:attributes)
        |> Keyword.get(:_docout_config)
        |> case do
          nil ->
            []

          _config ->
            {:docs_v1, _anno, _lang, _format, _module_doc, _mod_meta, func_docs} = Code.fetch_docs(mod)

            [{mod, func_docs}]
        end
      end)

    :docout
    |> Application.get_env(:formatters, [])
    |> Enum.each(fn mod ->
      "docs"
      |> Path.join(build_filename(mod))
      |> Mix.Generator.create_file(mod.format(docs), force: true)
    end)
  end

  defp build_filename(mod) do
    mod
    |> to_string()
    |> String.split(".")
    |> List.last()
    |> Macro.underscore()
  end
end
