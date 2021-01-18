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

    def append(a, b) do
        [a | b]
    end
end