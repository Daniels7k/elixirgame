defmodule ElixirgameTest do
  use ExUnit.Case
  doctest Elixirgame

  test "greets the world" do
    assert Elixirgame.hello() == :world
  end
end
