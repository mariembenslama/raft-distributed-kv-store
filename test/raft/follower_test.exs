defmodule RaftDistributedKVStore.Raft.FollowerTest do
  use ExUnit.Case, async: true
  alias RaftDistributedKVStore.Raft.Follower

  @node_name "follower_node"

  setup do
    # Ensure the follower process is started for each test
    {:ok, pid} = Follower.start_link(@node_name)
    {:ok, pid: pid}
  end

  test "starts the follower process", %{pid: pid} do
    # Ensure that the process has been started by checking its PID
    assert Process.alive?(pid)
  end

  test "receives a heartbeat and updates last_heartbeat", %{pid: pid} do
    # Send a heartbeat with a term of 1
    assert :ok == Follower.receive_heartbeat(@node_name, :heartbeat, 1)

    # Ensure that the last_heartbeat term is updated to 1
    follower_state = :sys.get_state(pid)
    assert follower_state.last_heartbeat == 1
  end

  test "receives a heartbeat with a new term and updates last_heartbeat", %{pid: pid} do
    # Send a heartbeat with term 1
    assert :ok == Follower.receive_heartbeat(@node_name, :heartbeat, 1)

    # Send another heartbeat with a new term (term 2)
    assert :ok == Follower.receive_heartbeat(@node_name, :heartbeat, 2)

    # Ensure that the last_heartbeat term is updated to 2
    follower_state = :sys.get_state(pid)
    assert follower_state.last_heartbeat == 2
  end
end
