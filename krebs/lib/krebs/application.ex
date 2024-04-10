defmodule Krebs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Krebs.Server

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Krebs.Worker.start_link(arg)
      # {DynamicSupervisor, name: :dsup, strategy: :one_for_one}
      {Server, :krebs}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Krebs.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
