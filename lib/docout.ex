defmodule Docout do
  @moduledoc """
    Use this module in another module to mark it for doc formatting.

    Docs for all functions in the module will be passed to configured formatters for processing.

    defmodule SomeModule do
      @moduledoc docout: true

      @doc "these docs will be passed to formatter"
      @doc meta: "this too"
      def some_func, do: :ok
    end
  """
  @moduledoc docout: true


  @doc """
  Extracts func docs from a list of modules and passes them to configured formatters.
  """
  @doc args: [
    modules: "list of modules to extract docs from, if configured to use docout"
  ]
  @doc returns: "`:ok`"
  def process(modules) do
    docs =
      modules
      |> Enum.flat_map(fn mod ->
        {:docs_v1, _anno, _lang, _format, _mod_docs, mod_meta, func_docs} = Code.fetch_docs(mod)

        if Map.get(mod_meta, :docout, false) do
          [{mod, func_docs}]
        else
          []
        end
      end)

    :docout
    |> Application.get_env(:formatters, [])
    |> Enum.each(fn mod ->
      Mix.Generator.create_file(build_path(mod), mod.format(docs), force: true)
    end)
  end

  defp build_path(mod) do
    case Application.get_env(:docout, mod)[:output_path] do
      nil -> Path.join("docs", build_filename(mod))
      path -> path
    end
  end

  defp build_filename(mod) do
    mod
    |> to_string()
    |> String.split(".")
    |> List.last()
    |> Macro.underscore()
  end
end
