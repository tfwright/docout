defmodule Docout.Formatter do
  @moduledoc false

  @type func_docs :: [tuple()]
  @type mod_name :: atom()
  @type doc :: %{optional(binary()) => binary()} | :none | :hidden
  @type metadata :: map()
  @type docout_data :: {{kind :: atom(), function_name :: atom(), arity()}, function_doc :: doc, metadata}
  @type doc_list :: [{module_doc :: doc, metadata, [docout_data]}]

  @callback format(doc_list) :: String.t()
end
