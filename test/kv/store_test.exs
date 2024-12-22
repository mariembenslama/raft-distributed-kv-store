defmodule RaftDistributedKVStore.KV.StoreTest do
  use ExUnit.Case, async: true
  alias RaftDistributedKVStore.KV.Store

  setup do
    {:ok, _pid} = Store.start_link([])
    :ok
  end

  test "can set and get a value" do
    assert Store.put("key1", "value1") == :ok
    assert Store.get("key1") == {:ok, "value1"}
  end

  test "returns :not_found for non-existent keys" do
    assert Store.get("nonexistent") == :not_found
  end

  test "can overwrite an existing value" do
    assert Store.put("key1", "value1") == :ok
    assert Store.put("key1", "new_value") == :ok
    assert Store.get("key1") == {:ok, "new_value"}
  end

  test "handles getting a value from an empty store" do
    assert Store.get("key1") == :not_found
  end

  test "can handle multiple keys" do
    assert Store.put("key1", "value1") == :ok
    assert Store.put("key2", "value2") == :ok
    assert Store.get("key1") == {:ok, "value1"}
    assert Store.get("key2") == {:ok, "value2"}
  end
end
