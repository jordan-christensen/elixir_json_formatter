defmodule JsonFormatterTest do
  use ExUnit.Case
  doctest JsonFormatter

  test "greets the world" do
    assert JsonFormatter.hello() == :world
  end
end
