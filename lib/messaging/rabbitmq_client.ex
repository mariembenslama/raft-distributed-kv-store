defmodule RaftDistributedKVStore.Messaging.RabbitMQClient do
  @moduledoc """
  A simple RabbitMQ client for message passing between Raft nodes.

  This module is responsible for handling communication between the nodes using
  RabbitMQ queues. It includes methods for connecting to RabbitMQ, publishing
  messages, and consuming messages from queues.
  """

  use AMQP

  @doc """
  Establishes a connection to RabbitMQ and opens a channel.

  ## Returns
    - {:ok, channel} on success, where channel is the opened RabbitMQ channel.
  """
  def connect do
    {:ok, conn} = Connection.open("amqp://guest:guest@localhost")
    {:ok, chan} = Channel.open(conn)
    {:ok, chan}
  end

  @doc """
  Publishes a message to the specified RabbitMQ queue.

  ## Parameters
    - chan: The RabbitMQ channel to use.
    - queue: The queue name where the message should be published.
    - message: The message to be published.

  ## Returns
    - :ok on successful message publish.
  """
  def publish_message(chan, queue, message) do
    Queue.declare(chan, queue, durable: true)
    Basic.publish(chan, "", queue, message)
  end

  @doc """
  Consumes messages from a RabbitMQ queue.

  ## Parameters
    - chan: The RabbitMQ channel to use.
    - queue: The queue from which messages will be consumed.

  ## Returns
    - {:ok, consumer_tag} on success, where consumer_tag is the tag associated with the consumer.
  """
  def consume_messages(chan, queue) do
    Queue.declare(chan, queue, durable: true)
    Basic.consume(chan, queue, nil, no_ack: true)
  end
end
