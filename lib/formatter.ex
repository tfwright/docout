defmodule Docout.Formatter do
  @moduledoc false

  @callback format(List.t()) :: String.t()
end
