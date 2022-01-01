defmodule Docout.Formatters.OpenApiSpex do
  @moduledoc """
    Process docs in OpenApiSpex format. Requires OpenApiSpex dep.

    Configure the base path for the api:

    ```
    config :docout, Docout.Formatters.OpenApiSpex,
                    base_path: "/api/v1",
                    router: MyAppWeb.Router,
                    spec: MyAppWeb.SpecModule
    ```
  """

  def format(docs) do
    paths =
      docs
      |> Enum.flat_map(fn {mod, _func_docs} ->
         Application.fetch_env!(:docout, Docout.Formatters.OpenApiSpex)[:router].__routes__()
        |> Enum.filter(&(mod == &1.plug))
      end)
      |> OpenApiSpex.Paths.from_routes()
      |> Enum.map(fn {path, def} -> {String.trim_leading(path, base_path()), def} end)
      |> Enum.into(%{})

    Application.fetch_env!(:docout, Docout.Formatters.OpenApiSpex)[:spec].spec()
    |> Map.replace!(:paths, paths)
    |> Jason.encode!()
  end

  defp base_path, do: Application.get_env(:docout, Docout.Formatters.OpenApiSpex, %{})[:base_path]
end
