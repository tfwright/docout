defmodule DocoutTest do
  use ExUnit.Case
  doctest Docout

  test "greets the world" do
    assert Docout.hello() == :world
  end
end
