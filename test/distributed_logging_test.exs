defmodule DistributedLoggingTest do
  use ExUnit.Case
  doctest DistributedLogging

  test "greets the world" do
    assert DistributedLogging.hello() == :world
  end
end
