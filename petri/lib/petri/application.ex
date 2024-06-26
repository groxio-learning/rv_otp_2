defmodule Petri.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Petri.Server
  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Petri.Worker.start_link(arg)
      # {Petri.Worker, arg}
      Server
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Petri.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
