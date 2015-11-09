using Hurricane

function quicksort(list::Array{Int})
  if length(list) < 2
    return list
  end

  pivot = list[1]
  left = filter(x -> x < pivot, list)
  right = filter(x -> x ≥ pivot, list[2:end])

  return [quicksort(left) ; pivot ; quicksort(right)]
end

function quicksort_parallel(list::Array{Int})
  if length(list) < 2
    return list
  end

  pivot = list[1]
  left = filter(x -> x < pivot, list)
  right = filter(x -> x ≥ pivot, list[2:end])
  @join begin
    return [@go(quicksort_parallel(left)) ; pivot ; @go(quicksort_parallel(right))]
  end
end

println("Using quicksort alloc")
@show quicksort([2, 1, 3])
nums = rand(1:1_000, 1_000)
@time quicksort(nums)

println("Using quicksort parallel")
@show quicksort_parallel([2, 1, 3])
nums = rand(1:1_000, 1_000)
@time quicksort_parallel(nums)
