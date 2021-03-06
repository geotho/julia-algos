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
    sorted_left = @go(quicksort_parallel(left))
    sorted_right = @go(quicksort_parallel(right))
  end
  return [sorted_left ; pivot ; sorted_right]
end

println("Using quicksort alloc")
@show quicksort([2, 1, 3])
nums = rand(1:100_000, 100000)
@time quicksort(nums)

println()
println("Using quicksort parallel")
@show quicksort_parallel([2, 1, 3])
nums = rand(1:100_000, 100000)
@time quicksort_parallel(nums)
