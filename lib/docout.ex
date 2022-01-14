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

  @behaviour __MODULE__.Parser

  @doc """
  Extracts func docs from a list of modules and passes them to configured formatters.
  """
  @doc args: [
         modules: "list of modules to extract docs from, if configured to use docout"
       ]
  @doc returns: "`:ok`"
  def process(modules) do
    :docout
    |> Application.get_env(:formatters, [])
    |> Enum.each(fn formatter ->
      docs =
        Enum.flat_map(modules, fn mod ->
          docs = {:docs_v1, _, _, _, _, mod_meta, _} = Code.fetch_docs(mod)

          if formatter_match?(mod_meta, formatter) do
            :docout
            |> Application.get_env(:parser, __MODULE__)
            |> apply(:parse, [mod, docs])
          else
            []
          end
        end)

      Mix.Generator.create_file(build_path(formatter), formatter.format(docs), force: true)
    end)
  end

  @impl true
  def parse(mod, {_, _, _, _, mod_doc, mod_meta, func_docs}) do
    formatted_docs =
      Enum.flat_map(func_docs, fn
        {def, _, _, heredoc, meta} -> [{def, heredoc, meta}]
        _ -> []
      end)

    [{mod, mod_doc, mod_meta, formatted_docs}]
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

  defp formatter_match?(%{docout: true}, _formatter), do: true
  defp formatter_match?(%{docout: formatters}, formatter), do: Enum.member?(formatters, formatter)
  defp formatter_match?(_, _), do: false
end
