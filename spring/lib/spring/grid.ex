defmodule Spring.Grid do
  def new() do
    w = 10
    h = 10
    for r <- 1..w, c <- 1..h, into: %{}, do: {{r, c}, Enum.random([true, false])}
  end

  def evolve(grid) do
    Enum.map(grid, fn {{rr, cc}, state} ->
      n_count = get_count(grid, rr, cc)
      new_state = Spring.Cell.evolve(state, n_count)
      {{rr, cc}, new_state}
    end)
    |> Map.new()
  end

  def get_count(grid, rr, cc) do
    l = for r <- (rr - 1)..(rr + 1), c <- (cc - 1)..(cc + 1), {r, c} != {rr, cc}, do: Map.get(grid, {r, c}, false)
    Enum.count(l, fn cell -> cell end)
  end

end
