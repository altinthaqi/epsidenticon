defmodule Epsidenticon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
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

  def build_grid(%Epsidenticon.Image{hex: hex_list} = image) do
    grid =
      hex_list
      |> Enum.chunk(3)
      |> Enum.map(&mirrow_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Epsidenticon.Image{image | grid: grid}
  end

  def mirrow_row(row) do
    case row do
      [first, second | _tail] ->
        row ++ [second, first]

      _ ->
        nil
    end
  end

  def filter_odd_squares(%Epsidenticon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Epsidenticon.Image{image | grid: grid}
  end

  def build_pixel_map(%Epsidenticon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Epsidenticon.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Epsidenticon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  def save_image(image, input) do
    unix = DateTime.to_unix(DateTime.utc_now())
    dir = "identicons/#{input}-#{unix}.png"

    with :ok <- File.mkdir_p(Path.dirname(dir)) do
      File.write(dir, image)
    end
  end
end
