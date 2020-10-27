defmodule DistributedLogging.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(scheme: :http,
        plug: DistributedLogging.Router,
        options: [port: 8001]),
      Plug.Adapters.Cowboy.child_spec(scheme: :http,
        plug: DistributedLogging.Node1,
        options: [port: 5555]),
      Plug.Adapters.Cowboy.child_spec(scheme: :http,
        plug: DistributedLogging.Node2,
        options: [port: 5556]),
      Plug.Adapters.Cowboy.child_spec(scheme: :http,
        plug: DistributedLogging.Node3,
        options: [port: 5557])
      # Starts a worker by calling: DistributedLogging.Worker.start_link(arg)
      # {DistributedLogging.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DistributedLogging.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
