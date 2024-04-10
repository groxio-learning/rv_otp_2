defmodule Spring.Server do
  use GenServer
  alias Spring.Grid

  def start_link(grid) do
    GenServer.start_link(Spring.Server, grid, name: :grid)
  end

  def show(grid) do
    grid_str =
      1..20
      |> Enum.map(fn r ->
        1..20
        |> Enum.map(fn c ->
          Spring.Cell.get_status(Map.get(grid, {r, c}, false))
        end)
        |> Enum.join(" ")
      end)
      |> Enum.join("\n")

    IO.puts grid_str
  end

  def evolve() do
    GenServer.cast(:evolve)
  end

# Server

@impl true
def init(grid) do
  {:ok, grid}
end

@impl true
def handle_call(:show, _from, grid) do
  {:reply, grid, grid}
end

@impl true
def handle_cast(:evolve, grid) do
  new_grid = Grid.evolve(grid)
  {:noreply, new_grid}
end
end
