defmodule Mix.Tasks.Compile.Docout do
  @moduledoc false
  use Mix.Task

  def run(_args) do
    app_name = Application.compile_env!(:docout, :app_name)

    IO.inspect(app_name)

    :ok = Application.ensure_loaded(app_name)

     :application.get_key(app_name)
     |> IO.inspect(label: "loaded application")

    {:ok, modules} = :application.get_key(app_name, :modules)

    Docout.process(modules)

    :ok
  end
end
