defmodule Sorting do
    # use <
    def insert(element, []) do [ element ] end
    def insert(element, [ head | tail ]) do 
        ^element < ^head -> [ element | [ head | tail ] ]
        _                -> [ head | insert(element, tail) ]
    end

    def isort([]) do [] end
    def isort([ x ]) do [ x ] end
    def isort(list) do 
        isort(list, [])
    end 
    def isort([], sorted) do sorted end
    def isort([ head | tail ], sorted) do
        insert(head, sorted)
    end
end