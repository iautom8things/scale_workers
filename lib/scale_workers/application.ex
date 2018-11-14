defmodule ScaleWorkers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    topologies = [
      swarm_example: [
        strategy: ClusterDocker.Strategy.Service
      ]
    ]

    # List all child processes to be supervised
    children = [
      {Cluster.Supervisor, [topologies, [name: ScaleWorkers.ClustSupervisor]]},
      ScaleWorkers.ClusterSupervisor
      # Starts a worker by calling: ScaleWorkers.Worker.start_link(arg)
      # {ScaleWorkers.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScaleWorkers.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
