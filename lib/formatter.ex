defmodule Docout.Formatter do
  @moduledoc false

  @callback format(any()) :: String.t()
end
