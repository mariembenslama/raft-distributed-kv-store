defmodule RaftDistributedKVStore.MixProject do
  use Mix.Project

  def project do
    [
      app: :raft_distributed_kv_store,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:amqp, "~> 3.0"},
      {:dialyxir, "~> 1.1", only: [:dev], runtime: false},
      {:git_hooks, "~> 0.6.0", only: :dev},
      {:excoveralls, "~> 0.14", only: :test} # Add ExCoveralls dependency
    ]
  end
end
