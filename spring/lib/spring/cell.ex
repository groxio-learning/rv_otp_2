defmodule Spring.Cell do

  def get_status(state) do
    # match state to true of false
    if state == true do
      "X"
    else
      "O"
    end
  end

  def evolve(state, n_count) do
    cond do
      n_count == 3 -> true
      n_count == 2 -> state
      true -> false
    end
  end
end
