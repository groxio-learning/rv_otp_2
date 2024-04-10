# offset, new project snowflake --sup
defmodule Krebs.Grid do
  @height 20
  @width 20

  def init() do
    for row <- 1..@width, col <- 1..@height, into: %{}, do: {{row, col}, Enum.random([true, false])}
  end

  @type board :: %{
    {number(), number()} => boolean()
  }

  @doc """
  Take in a board and return the next board state after evaluating each cell
  """
  @spec evolve(board()) :: board()
  def evolve(board) do

    board
    |> Enum.reduce(%{}, fn { coordinates, _state }, acc ->
      Map.put(acc, coordinates, do_evolve(coordinates, board))
    end )
  end

  @spec do_evolve({number(), number()}, board()) :: [boolean()]
  defp do_evolve({rr, cc} = coordinates, board) do
    for r <- (rr - 1)..(rr + 1), c <- (cc - 1)..(cc + 1), {r, c} != {rr, cc} do
      Map.get(board, {r, c}, false)
    end
    |> Enum.count(fn x -> x end)
    |> Krebs.Cell.next_gen(board[coordinates])
  end
end
