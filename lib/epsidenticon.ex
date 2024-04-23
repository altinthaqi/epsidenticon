defmodule Epsidenticon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Epsidenticon.Image{hex: hex}
  end

  def pick_color(%Epsidenticon.Image{hex: [r, g, b | _tail]} = image) do
    %Epsidenticon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Epsidenticon.Image{hex: hex_list}) do
    hex_list
    |> Enum.chunk_every(3)
    |> Enum.map(&mirrow_row/1)
  end

  def mirrow_row(row) do
    case row do
      [first, second | _tail] ->
        row ++ [second, first]

      _ ->
        nil
    end
  end
end
