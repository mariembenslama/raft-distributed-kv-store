defmodule RaftDistributedKVStore.Raft.Leader do
  @moduledoc """
  The Leader state in the Raft consensus protocol.

  When a node is in the Leader state, it is responsible for managing log replication
  and maintaining consistency across the cluster. It sends heartbeats to followers
  and handles log entry replication.
  """

  use GenServer

  @doc """
  Starts the Leader process.

  ## Parameters
    - node_name: The name of the leader node.

  ## Returns
    - {:ok, pid} on success, where pid is the process identifier.
  """
  def start_link(node_name) do
    GenServer.start_link(__MODULE__, node_name, name: String.to_atom(node_name))
  end

  @doc """
  Sends a heartbeat to the followers to maintain leadership.

  ## Parameters
    - node_name: The name of the leader node.
    - term: The current term of the leader.

  ## Returns
    - :ok when the heartbeat is successfully sent.
  """
  def send_heartbeat(node_name, term) do
    GenServer.call(String.to_atom(node_name), {:send_heartbeat, term})
  end

  # GenServer Callbacks

  def init(node_name), do: {:ok, %{node: node_name, term: 0}}

  def handle_call({:send_heartbeat, term}, _from, state) do
    # Simulate sending heartbeat to followers
    {:reply, :ok, %{state | term: term}}
  end
end
