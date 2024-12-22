## RaftDistributedKVStore

RaftDistributedKVStore is an implementation of a distributed key-value store based on the Raft consensus algorithm. This project provides a simple key-value store with a Raft-based leader election mechanism and fault tolerance, using Elixir’s GenServer for state management. The store can be extended to support more advanced distributed system concepts, such as log replication, heartbeats, and leader election.

## Raft Protocole animated example
https://thesecretlivesofdata.com/raft

## Features

- **Raft Consensus Algorithm**: Implements Raft's candidate, follower, and leader states to ensure fault tolerance and consistent log replication across nodes.
- **In-memory Key-Value Store**: A simple key-value store that operates within a distributed environment, using GenServer to store and retrieve data.
- **RabbitMQ Integration**: For message passing and cluster communication (using the `amqp` package).
- **Testing and Coverage**: Includes comprehensive unit tests and coverage reporting with tools like `ExUnit` and `ExCoveralls`.

## Installation

To get started with RaftDistributedKVStore, clone this repository and install the dependencies using mix.

1. Clone the repository
```shell
git clone https://github.com/yourusername/raft_distributed_kv_store.git
cd raft_distributed_kv_store
```
2. Install dependencies
This project uses mix to manage dependencies. Install the required dependencies with the following command:
```shell
mix deps.get
```
3. Running the application
To start the application, run the following:
```shell
iex -S mix
```
You can now interact with the `RaftDistributedKVStore` application in the Elixir interactive shell (IEx).

4. Running tests
To run the tests for this project, simply execute:
```shell
mix test
```
5. Generating Coverage Report
To generate an HTML coverage report, use the following command:
```shell
mix coveralls.html
```
You can find the report in the coveralls/ directory. Open coveralls/index.html in your browser to view the detailed coverage report.

##Raft Consensus Protocol

This project implements the Raft consensus algorithm, which ensures that the distributed system maintains consistency across all nodes. The Raft protocol operates through three main states:

- **Leader**: The leader is responsible for managing log replication and sending heartbeats to followers. The leader also handles log entry replication.
- **Follower**: A passive state that listens for heartbeats from the leader or transitions to the Candidate state if no heartbeat is received for a given time.
- **Candidate**: When a node becomes a candidate, it attempts to become the leader by requesting votes from other nodes. If it gets a majority, it becomes the leader.
Each of these states is implemented as a GenServer in the project.

## Key-Value Store

The key-value store is implemented using Elixir’s GenServer. The store supports basic `put/2` and `get/1 `operations to store and retrieve key-value pairs. It uses an in-memory state for simplicity.

Example usage
#### Start the key-value store
```erlang
{:ok, _pid} = RaftDistributedKVStore.KV.Store.start_link([])
```
#### Store a key-value pair
```erlang
RaftDistributedKVStore.KV.Store.put("key1", "value1")
```
#### Retrieve the value associated with the key
```erlang
{:ok, value} = RaftDistributedKVStore.KV.Store.get("key1")
IO.puts("Value for key1: #{value}")
```

## RabbitMQ Integration

The project integrates RabbitMQ for messaging between nodes. The RaftDistributedKVStore.Messaging.RabbitMQClient module provides functionality to interact with RabbitMQ.

Example usage
#### Start the RabbitMQ client
```erlang
{:ok, chan} = RaftDistributedKVStore.Messaging.RabbitMQClient.connect()
```
#### Publish a message
```erlang
RaftDistributedKVStore.Messaging.RabbitMQClient.publish_message(chan, "queue_name", "message")
```
#### Consume messages
```erlang
RaftDistributedKVStore.Messaging.RabbitMQClient.consume_messages(chan, "queue_name")
```

## Testing

This project includes unit tests for each of its components. You can run the tests using mix test.

#### Test Coverage
To check the code coverage of your tests, run:

```shell
mix coveralls.html
```
You can then open the generated `coveralls/index.html` in your browser to review the coverage report.

## Contributing

Feel free to fork the repository and contribute improvements. Whether it's bug fixes, new features, or general improvements, contributions are always welcome.

#### How to contribute
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a pull request