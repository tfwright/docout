defmodule Docout.Formatter do
  @moduledoc false

  @type func_docs :: [tuple()]
  @type mod_name :: atom()
  @type doc_list :: [{mod_name, func_docs}]

  @callback format(doc_list) :: String.t()
end
