defmodule RaftDistributedKVStore.Raft.Candidate do
  @moduledoc """
  The Candidate state in the Raft consensus protocol.

  When a node is in the Candidate state, it attempts to become the leader
  by requesting votes from other nodes. If it receives a majority of votes,
  it becomes the leader. Otherwise, it will continue attempting to become the leader.
  """

  use GenServer

  @doc """
  Starts the Candidate process.

  ## Parameters
    - node_name: The name of the candidate node that is trying to become the leader.

  ## Returns
    - {:ok, pid} on success, where pid is the process identifier.
  """
  def start_link(node_name) do
    GenServer.start_link(__MODULE__, node_name, name: String.to_atom(node_name))
  end

  @doc """
  Requests a vote from the current Raft cluster.

  ## Parameters
    - node_name: The name of the node requesting the vote.
    - current_term: The current term of the node.

  ## Returns
    - {:ok, :vote_granted} if the vote is granted.
    - {:error, :vote_rejected} if the vote is not granted.
  """
  def request_vote(node_name, current_term) do
    GenServer.call(String.to_atom(node_name), {:request_vote, current_term})
  end

  # GenServer Callbacks

  def init(node_name), do: {:ok, %{node: node_name, votes: 0}}

  def handle_call({:request_vote, current_term}, _from, state) do
    # Simplified voting logic for candidate election
    new_state = if state.votes < 2 do
      %{state | votes: state.votes + 1}
    else
      state
    end
    {:reply, :vote_granted, new_state}
  end
end
