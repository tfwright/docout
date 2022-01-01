defmodule Docout.Formatters.OpenApiSpex do
  @moduledoc """
    Process docs in OpenApiSpex format. Requires OpenApiSpex dep.
  """

  def format(docs) do
    paths =
      docs
      |> Enum.flat_map(fn {mod, _func_docs} ->
        BlocksCoreWeb.Router.__routes__()
        |> Enum.filter(&(mod == &1.plug))
      end)
      |> OpenApiSpex.Paths.from_routes()
      |> Enum.map(fn {path, def} -> {String.trim_leading(path, base_path()), def} end)
      |> Enum.into(%{})

    BlocksCoreWeb.V1.Specs.spec()
    |> Map.replace!(:paths, paths)
    |> Jason.encode!()
  end

  defp base_path, do: Application.get_env(:docout, Docout.Formatters.OpenApiSpex, %{})[:base_path]
end
