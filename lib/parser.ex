defmodule Docout.Parser do
  @moduledoc false

  @type mod_name :: atom()
  @type doc :: %{optional(binary()) => binary()} | :none | :hidden
  @type metadata :: map()
  @type(func_signature :: kind :: atom(), function_name :: atom(), arity())
  @type func_docs :: [{func_signature, :erl_anno.anno(), [binary()], doc, metadata}]
  @type doc_tuple ::
          {:docs_v1, :erl_anno.anno(), :elixir | :erlang | atom(), binary(), doc, metadata,
           [func_docs]}

  @callback parse(mod_name, doc_tuple) :: [any()]
end
