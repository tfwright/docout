defmodule Docout.Formatters.Demo do
  @behaviour Docout.Formatter

  @impl true
  def format(doc_list) do
    doc_list
    |> Enum.reduce("# Docout sample doc\n", fn {mod, docs}, output ->
      output = output <> "## #{mod}\n"
      Enum.reduce(docs, output, fn {{_, name, arity}, _, _, %{"en" => desc}, %{args: args, returns: returns}}, output ->
        output <> """
          ### #{name}/#{arity}

          *#{String.trim(desc)}*

          Args:

          #{Enum.map_join(args, "\n", fn {name, desc} -> "* #{name}: #{desc}" end)}


          Returns: #{returns}
        """
      end)
    end)
  end
end
