defmodule Binary do
    use Bitwise

    def to_binary(0) do [] end
    def to_binary(n) do
        Lists.append(rem(n, 2), to_binary(div(n, 2)))
    end


    def to_better(n) do to_better(n, []) end
    def to_better(0, b) do b end
    def to_better(n, b) do
      to_better(div(n, 2), [rem(n, 2) | b])
    end


    def to_integer(x) do to_integer(x, 0) end
    def to_integer([], n) do n end
    def to_integer([x | r], n) do
      to_integer(r, n + x * (1 <<< length(r)))
    end    
end