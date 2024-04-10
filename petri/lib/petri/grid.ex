defmodule Petri.Grid do
  @moduledoc """
  A grid of cells in a Petri game.
  """

  def new(width \\ 10, height \\ 10) do
    for x <- 1..width, y <- 1..height, into: %{} do
      {{x, y}, Enum.random([true, false])}
    end
  end

  def count_neighbors(grid, {x, y}) do
    for xx <- (x - 1)..(x + 1),
        yy <- (y - 1)..(y + 1),
        {x, y} != {xx, yy} do
      Map.get(grid, {xx, yy}, false)
    end
    |> Enum.count(fn cell -> cell end)
  end

  def evolve(grid) do
    grid
    |> Enum.map(fn {{x, y}, cell} ->
      {{x, y}, Petri.Cell.next_gen(cell, count_neighbors(grid, {x, y}))}
    end)
    |> Enum.into(%{})
  end

  def show(grid) do
    grid
    |> Enum.sort()
    |> Enum.chunk_every(10)
    |> Enum.map(&show_row/1)
    |> Enum.join("\n")
    |> IO.puts()
  end

  def show_row(row) do
    row
    |> Enum.map(fn {_, value} -> Petri.Cell.show(value) end)
    |> Enum.join(" ")
  end
end
