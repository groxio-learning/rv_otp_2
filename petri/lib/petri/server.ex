defmodule Petri.Server do
  use GenServer
  alias Petri.Grid

  def start_link(_input) do
    IO.puts("Starting Petri.Server")
    GenServer.start_link(__MODULE__, :unused, name: :petri)
  end

  def evolve() do
    GenServer.cast(:petri, :evolve)
  end

  def show() do
    GenServer.call(:petri, :show)
    |> Grid.show()
    |> IO.puts()
  end

  @impl true
  def init(_unused) do
    {:ok, Grid.new()}
  end

  @impl true
  def handle_cast(:evolve, grid) do
    {:noreply, Grid.evolve(grid)}
  end

  @impl true
  def handle_call(:show, _from, grid) do
    {:reply, grid, grid}
  end
end
