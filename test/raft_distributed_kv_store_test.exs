defmodule RaftDistributedKVStoreTest do
  use ExUnit.Case
  doctest RaftDistributedKVStore

  test "greets the world" do
    assert RaftDistributedKVStore.hello() == :world
  end
end
