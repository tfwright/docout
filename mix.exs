defmodule Docout.MixProject do
  use Mix.Project

  def project do
    [
      app: :docout,
      name: "Docout",
      version: "0.1.0",
      elixir: "~> 1.0",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/tfwright/docout",
      compilers: Mix.compilers() ++ compilers(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def package do
    [
      name: "docout",
      files: ~w(demo lib priv .formatter.exs mix.exs README* readme* LICENSE*
              license* CHANGELOG* changelog* src),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/tfwright/docout"}
    ]
  end

  def description do
    """
    Generate documentation files from your existing Elixir app docs at compile time.
    """
  end

  def application, do: []

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp compilers do
    if System.get_env("DOCOUT_SELF") == "t" do
      [:docout]
    else
      []
    end
  end

  defp elixirc_paths(:dev), do: ["lib", "demo"]
  defp elixirc_paths(_), do: ["lib"]
end
