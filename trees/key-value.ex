defmodule KeyValue do
    def lookup(k, {:node, k, _, _, _}) do :yes end
    def lookup(k, {:node, ki, _, left, _}) when k < ki do
           member(e, left)
    end
    def lookup(k, {:node, _, _, right})  do
           member(e, right)
    end

    def add(k, v, :nil) do {:node, k, v, :nil, :nil}
    def add(k, v, {:node, ki, vi, :nil, right}) when k < ki do 
        {:node, ki, vi, add(k, v, :nil), right}
    end
    def add(k, v, {:node, ki, vi, left, :nil}) do
        {:node, ki, vi, left, add(k, v, :nil)}
    end
    def add(k, v, {:node, ki, vi, left, right }) when k < ki do
       {:node, ki, vi, insert(k, v, left), right}
    end
    def add(k, v, {:node, ki, vi, left, right })  do
       {:node, ki, vi, left, insert(k, v, right)}
    end


    def rightmost({:node, k, v, _, :nil}) do {k, v} end
    def rightmost({:node, _, _ , right}) do  rightmost(right)  end

    def remove(k, {:node, k, _, :nil, :nil}) do :nil end
    def remove(k, {:node, k, _, :nil, right}) do  right  end
    def remove(k, {:node, k, _, left, :nil}) do  left  end
    def remove(k, {:node, k, _, left, right}) do
        {ki, vi} = rightmost(left)
        {:node, ki, vi, remove(ki, left), right}
    end
    def remove(k, {:node, ki, v, left, right}) when k < ki do
        {:node, ki, vi, delete(k, left), right}
    end
    def remove(k, {:node, ki, v, left, right})  do
        {:node, k, v, left, delete(k, right)}
    end
end