defmodule Mix.Tasks.Compile.Docout do
  @moduledoc false
  use Mix.Task

  @requirements ["loadpaths"]

  def run(_args) do
    app_name = Application.fetch_env!(:docout, :app_name)

    Application.ensure_loaded(app_name)

    {:ok, modules} = :application.get_key(app_name, :modules)

    Docout.process(modules)

    :ok
  end
end
