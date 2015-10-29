function quicksort(list::Array{Int})
  if length(list) < 2
    return list
  end

  pivot = list[1]
  left = filter(x -> x < pivot, list)
  right = filter(x -> x ≥ pivot, list[2:end])

  return [quicksort(left) ; pivot ; quicksort(right)]
end

nums = rand(1:1_000_000, 1_000_000)
# print(nums, "\n")
# print(quicksort(nums), "\n")
quicksort([2,1,3])
@time quicksort(nums)
