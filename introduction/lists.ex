defmodule Lists do
    def tak(list) do
        if length(list) > 0 do
            [ head | _ ] = list
            {:ok, head}
        else
            :no
        end
    end

    def drp(list) do 
        if length(list) > 0 do
            [ _ | tail ] = list
            {:ok, tail}
        else
            :no
        end
    end

    def len([]) do 0 end
    def len([ _ | tail ]) do
        1 + case drp(tail) do
            {:ok, res} -> len(res)
            :no        -> 0
        end
    end
    
    def sum([]) do 0 end
    def sum([ head | tail ]) do
        head + case drp(tail) do
            {:ok, res} -> sum(res)
            :no        -> 0
        end
    end

    def duplicate([]) do [] end
    def duplicate([ head | tail ]) do  
        [ head | [ head | duplicate(tail) ] ]
    end

    def add(x, []) do [ x ] end
    def add(x, l) do
        [ head | tail ] = l
        case head do
            ^x -> l
            _  -> [ head | add(x, tail) ]
        end
    end

    def remove(_, []) do [] end
    def remove(x, [ head | tail ]) do
        case head do
            ^x -> remove(x, tail)
            _  -> [ head | remove(x, tail) ]
        end
    end

    def unique([]) do [] end
    def unique([ head | tail ]) do 
        [ head | remove(head, tail) ]
    end

    def append([], b) do b end
    def append([ head | tail ], b) do
        [ head | append(tail, b)]
    end

    defmodule Reverse_benching do
        def nreverse([]) do [] end
        def nreverse([h | t]) do
          r = nreverse(t)
          Lists.append(r, [h])
        end


        def reverse(l) do
          reverse(l, [])
        end

        def reverse([], r) do r end
        def reverse([h | t], r) do
          reverse(t, [h | r])
        end

        def bench() do
          ls = [16, 32, 64, 128, 256, 512]
          n = 100
          # bench is a closure: a function with an environment.
          bench = fn(l) ->
            seq = Enum.to_list(1..l)
            tn = time(n, fn -> nreverse(seq) end)
            tr = time(n, fn -> reverse(seq) end)
            :io.format("length: ~10w  nrev: ~8w us    rev: ~8w us~n", [l, tn, tr])
          end
        
          # We use the library function Enum.each that will call
          # bench(l) for each element l in ls
          Enum.each(ls, bench)
        end
        
        # Time the execution time of the a function.
        def time(n, fun) do
          start = System.monotonic_time(:milliseconds)
          loop(n, fun)
          stop = System.monotonic_time(:milliseconds)
          stop - start
        end
        
        # Apply the function n times.
        def loop(n, fun) do
          if n == 0 do
            :ok
          else
            fun.()
            loop(n - 1, fun)
          end
        end
        # reverse is faster than nreverse because reverse traverses the list only once.
        # nreverse, however, traverses it n times for every item
    end
end