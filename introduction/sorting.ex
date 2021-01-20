defmodule Sorting do
    def insert(element, []) do [ element ] end
    def insert(element, [ head | tail ]) do 
        if element < head do
            [ element | [ head | tail ] ]
        else 
            [ head | insert(element, tail) ]
        end
    end

    def isort([]) do [] end
    def isort([ x ]) do [ x ] end
    def isort(list) do isort(list, []) end

    def isort([], sorted) do sorted end
    def isort([ head | tail ], sorted) do
        isort(tail, insert(head, sorted))
    end

    
    def msort(l) do 
        case l do 
            [ x ] -> [ x ] 
            _ -> 
                {left, right} = msplit(l, [], [])
                merge(msort(left), msort(right)) 
        end 
    end
    
    def merge([], right) do right end 
    def merge(left, []) do left end 
    # [5], [1,2] -> [5 | []], [1 | [2]]
    # 5 < 1 -> false
    # [1 | merge([5], [2])]
    #   [5], [2] -> [5 | []], [2, []]
    #   5 < 2 -> false
    #   [2 | merge([5], [])]
    #       [5], [] -> [5]
    # [1 | [2 | [5]]]
    # Doesn't work for some reason
    def merge(left, right) do 
       [ lhead | ltail ] = left
       [ rhead | rtail ] = right
       if lhead < rtail do
           [ lhead | merge(ltail, right) ] 
       else 
           [ rhead | merge(left, rtail) ]
       end 
    end
    
    def msplit(l, left, right) do 
        case l do 
            []           -> {left, right} 
            [ x | tail ] -> msplit(tail, right, [ x | left ]) 
        end
    end
end