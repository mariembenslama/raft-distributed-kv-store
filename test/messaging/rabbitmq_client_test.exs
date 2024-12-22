defmodule RaftDistributedKVStore.Messaging.RabbitMQClientTest do
  use ExUnit.Case, async: false
  alias RaftDistributedKVStore.Messaging.RabbitMQClient
  use AMQP

  setup do
    {:ok, chan} = RabbitMQClient.connect()
    {:ok, channel: chan}
  end

  test "connect establishes a connection and returns a channel", %{channel: chan} do
    assert chan.__struct__ == AMQP.Channel
  end

  test "publish_message publishes a message to a queue", %{channel: chan} do
    queue = "test_queue_publish"
    message = "Hello, RabbitMQ!"

    assert :ok == RabbitMQClient.publish_message(chan, queue, message)

    {:ok, _queue_info} = Queue.declare(chan, queue, durable: true)

    {:ok, _consumer_tag} = Basic.consume(chan, queue, nil, no_ack: false)
    receive do
      {:basic_deliver, received_message, _meta} ->
        assert received_message == message
    after
      1000 ->
        flunk("Message not received from queue")
    end
  end

  test "consume_messages consumes messages from a queue", %{channel: chan} do
    queue = "test_queue_consume"
    message = "Hello from consume test!"

    assert :ok == RabbitMQClient.publish_message(chan, queue, message)

    {:ok, consumer_tag} = RabbitMQClient.consume_messages(chan, queue)
    assert is_binary(consumer_tag)

    receive do
      {:basic_deliver, received_message, _meta} ->
        assert received_message == message
    after
      1000 ->
        flunk("Message not received from queue")
    end
  end
end
