defmodule Docout.Demo.Formatter do
  use Docout, output_path: "docs/demo.md"

  @impl true
  def format(doc_list) do
    doc_list
    |> Enum.reduce("# Docout sample doc\n", fn {mod, _mod_docs, _mod_meta, func_docs}, output ->
      output = output <> "## #{mod}\n"

      Enum.reduce(func_docs, output, fn
        {{_, name, arity}, %{"en" => desc}, %{args: args, returns: returns}}, output ->
          output <>
            """
              ### #{name}/#{arity}

              *#{String.trim(desc)}*

              Args:

              #{Enum.map_join(args, "\n", fn {name, desc} -> "* #{name}: #{desc}" end)}


              Returns: #{returns}
            """
          _, output -> output
      end)
    end)
  end
end
