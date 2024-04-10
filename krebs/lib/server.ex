defmodule Krebs.Server do
  use GenServer

  alias Krebs.Grid


  # client
  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def evolve(pid) do
    GenServer.cast(pid, :evolve)
  end

  def show(pid) do
    GenServer.call(pid, :show)
    # |> IO.puts()
  end

  # server
  def init(_unused) do
    {:ok, Grid.init()}
  end

  def handle_call(:show, _from, grid) do
    rendered_grid = Enum.reduce(grid, %{}, fn {coords, state}, acc -> Map.put(acc, coords, Krebs.Cell.show(state)) end)
    {:reply, grid, rendered_grid}
  end

  def handle_cast(:evolve, grid) do
    {:noreply, Grid.evolve(grid)}
  end
end
