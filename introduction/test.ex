defmodule Test do

  # Compute the double of a number
  def double(n) do
    n*2
  end

  # Convert from Fahrenheit to Celsius
  def convert_f_to_c(f) do
    (f - 32) / 1.8
  end

  def rectangle_area(side_a, side_b) do
    side_a * side_b
  end

  def square_area(side) do
    rectangle_area(side, side)
  end

  def circle_area(radius) do
    square_area(radius) * :math.pi
  end
end
