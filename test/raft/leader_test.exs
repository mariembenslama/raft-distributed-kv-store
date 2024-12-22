defmodule RaftDistributedKVStore.Raft.LeaderTest do
  use ExUnit.Case, async: true
  alias RaftDistributedKVStore.Raft.Leader

  @node_name "leader_node"

  setup do
    # Ensure the leader process is started for each test
    {:ok, pid} = Leader.start_link(@node_name)
    {:ok, pid: pid}
  end

  test "starts the leader process", %{pid: pid} do
    # Ensure that the process has been started by checking its PID
    assert Process.alive?(pid)
  end

  test "sends a heartbeat and updates term", %{pid: pid} do
    # Send a heartbeat with term 1
    assert :ok == Leader.send_heartbeat(@node_name, 1)

    # Ensure that the term is updated to 1 after the heartbeat
    leader_state = :sys.get_state(pid)
    assert leader_state.term == 1
  end

  test "sends heartbeats with multiple terms", %{pid: pid} do
    # Send a heartbeat with term 1
    assert :ok == Leader.send_heartbeat(@node_name, 1)

    # Send a heartbeat with term 2
    assert :ok == Leader.send_heartbeat(@node_name, 2)

    # Ensure that the term is updated to the latest value (term 2)
    leader_state = :sys.get_state(pid)
    assert leader_state.term == 2
  end
end
