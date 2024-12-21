defmodule RaftDistributedKVStore.Raft.Follower do
  @moduledoc """
  The Follower state in the Raft consensus protocol.

  When a node is in the Follower state, it is passive and listens for
  heartbeats or log entries from the leader. If it does not hear from the
  leader for a certain period, it may transition to the Candidate state to
  initiate a new election.
  """

  use GenServer

  @doc """
  Starts the Follower process.

  ## Parameters
    - node_name: The name of the follower node.

  ## Returns
    - {:ok, pid} on success, where pid is the process identifier.
  """
  def start_link(node_name) do
    GenServer.start_link(__MODULE__, node_name, name: String.to_atom(node_name))
  end

  @doc """
  Listens for heartbeats from the leader.

  ## Parameters
    - heartbeat: The heartbeat signal sent by the leader.
    - term: The current term of the leader.

  ## Returns
    - :ok when the heartbeat is successfully received.
  """
  def receive_heartbeat(node_name, heartbeat, term) do
    GenServer.call(String.to_atom(node_name), {:receive_heartbeat, heartbeat, term})
  end

  # GenServer Callbacks

  def init(node_name), do: {:ok, %{node: node_name, last_heartbeat: nil}}

  def handle_call({:receive_heartbeat, _heartbeat, term}, _from, state) do
    new_state = %{state | last_heartbeat: term}
    {:reply, :ok, new_state}
  end
end
