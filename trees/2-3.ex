defmodule Trees23 do
   # :nil
   # {:leaf, key, value} 
   # {:two, key, left, right}
   # {:three, k1, k2, left, middle, right}
   # temp: {:four, k1, k2, k3, left, m1, m2, right}

    def insert(k, v, :nil) do {:leaf, k, v} end
    def insert(k, v, {:leaf, ki, _} = l) when k <= ki do
        {:two, k, {:leaf, k, v}, l}
    end
    def insert(k, v, {:leaf, _, _} = l) do
        {:two, k, l, {:leaf, k, v}}
    end
    def insert(k, v, {:two, _, {:leaf, kl, _} = ll, {:leaf, kr, _} = lr}) do
        cond do
            k <= kl -> {:three, k, kl, {:leaf, k, v}, ll, lr}
            k <= kr -> {:three, kl, k, ll, {:leaf, k, v}, lr}
            true ->    {:three, kl, kr, ll, lr,{:leaf, k, v}}
        end
    end
    def insert(k, v, {:three, _, _, {:leaf, kl, _} = ll, {:leaf, km, _} = lm, {:leaf, kr, _} = lr}) do
        cond do
          k <= kl -> {:three, k, kl, km, {:leaf, k, v}, ll, lm, lr}
          k <= km -> {:three, kl, k, km, ll, {:leaf, k, v}, lm, lr}
          k <= kr -> {:three, kl, km, k, ll, lm, {:leaf, k, v}, lr}
          true ->    {:three, kl, kr, km,ll, lm, lr, {:leaf, k, v}}
        end
    end
    def insert(k, v, {:two, k1, left, right}) do
      cond do
        k <= k1 ->
          case insert(k, v, left) do
            {:four, q1, q2, q3, t1, t2, t3, t4} ->
              # left node < key -> qN <= k1
              {:three, q2, k1, {:two, q1, t1, t2}, {:two, q3, t3, t4}, right}
            updated ->
              {:two, k1, updated, right}
          end

        true ->
          case insert(k, v, right) do
            {:four, q1, q2, q3, t1, t2, t3, t4} ->
              # right node > key -> qN > k1
              {:three, k1, q2, left, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
            updated ->
              {:two, k1, left, updated}
          end
      end
    end
    def insert(k, v, {:three, k1, k2, left, middle, right}) do
        cond do
          k <= k1 ->
            case insert(k, v, left) do
              {:four, q1, q2, q3, t1, t2, t3, t4} ->
                {:four, q2, k1, k2, {:two, q1, t1, t2}, {:two, q3, t3, t4}, middle, right}
              updated ->
                {:three, k1, k2, updated, middle, right}
            end
          k <= k2 ->
            case insert(k, v, middle) do
              {:four, q1, q2, q3, t1, t2, t3, t4} ->
                {:four, k1, q2, k2, left, {:two, q1, t1, t2}, {:two, q3, t3, t4}, right}
              updated ->
                {:three, k1, k2, left, updated, right}
            end
          true ->
            case insert(k, v, right) do
              {:four, q1, q2, q3, t1, t2, t3, t4} ->
                {:four, k1, k2, q2, left, middle, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
              updated ->
                {:three, k1, k2, left, middle, updated}
            end
        end
    end

    def insert(key, value, root) do
      case insert(key, value, root) do
        {:four, q1, q2, q3, t1, t2, t3, t4} ->
          {:two, q2, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
        updated ->
          updated
      end
    end
end