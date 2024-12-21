defmodule RaftDistributedKVStore.KV.Store do
  @moduledoc """
  A simple in-memory key-value store implemented using Elixir's GenServer.

  Provides functionality to store and retrieve key-value pairs. This module
  handles the basic operations of the distributed KV store, where each node
  can put and get data from its own in-memory store.
  """

  use GenServer

  @doc """
  Starts the GenServer with the given initial state.

  ## Parameters
    - initial_state: The initial state of the key-value store. Defaults to an empty map.

  ## Returns
    - {:ok, pid} on success, where pid is the process identifier of the GenServer.
  """
  def start_link(initial_state \\ %{}) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @doc """
  Stores a key-value pair in the store.

  ## Parameters
    - key: The key to be stored.
    - value: The value associated with the key.

  ## Returns
    - :ok on success.
  """
  def put(key, value) do
    GenServer.call(__MODULE__, {:put, key, value})
  end

  @doc """
  Retrieves the value associated with a given key.

  ## Parameters
    - key: The key whose associated value should be retrieved.

  ## Returns
    - The value associated with the key, or nil if the key doesn't exist.
  """
  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  # GenServer Callbacks

  def init(state), do: {:ok, state}

  def handle_call({:put, key, value}, _from, state) do
    new_state = Map.put(state, key, value)
    {:reply, :ok, new_state}
  end

  def handle_call({:get, key}, _from, state) do
    value = Map.get(state, key, nil)
    {:reply, value, state}
  end
end
