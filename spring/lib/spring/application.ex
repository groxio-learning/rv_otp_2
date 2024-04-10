defmodule Spring.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Spring.Server

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Spring.Worker.start_link(arg)
      # {Spring.Worker, arg}
      Server
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Spring.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
