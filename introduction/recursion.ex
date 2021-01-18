defmodule Recursion do

  @doc """
  Compute the product between of n and m.

  product of n and m :
    if n is 0
      then ...
    otherwise
      the result ...
  """
  # For non-negative values
  # def prod(m, n) do
  #   case m do
  #     0 -> 0
  #     ... -> n + prod(m - 1, n)
  #   end
  # end

  # For negative values
  def prod(m, n) do
    case m do
      0 -> 0
      _ -> n + prod(abs(m) - 1, n)
    end
  end

  def power(n, p) do 
    case p do
        1 -> n
        _ -> n * power(n, p - 1)
    end
  end

  def qpower(n, p) do
    left = rem(p, 2)
    case p do
        1 -> n
        # If elixir compiler can't optimize for tail recursion within
        # functions, expand power(qpower...) to 
        # qpower(n, div(p - left, 2)) * qpower(n, div(p - left, 2))
        _ -> power(n, left) * power(qpower(n, div(p - left, 2)), 2)
    end
  end
end