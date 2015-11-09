function quicksort(list::Array{Int})
  if length(list) < 2
    return list
  end

  pivot = list[1]
  left = filter(x -> x < pivot, list)
  right = filter(x -> x ≥ pivot, list[2:end])

  return [quicksort(left) ; pivot ; quicksort(right)]
end

function quicksort_ip!(A::Array{Int})
  quicksort_ip!(A, 1, length(A))
end


function partition!(A::Array{Int}, lo::Int, hi::Int)
  pivot = A[hi]
  i = lo
  for j = i:hi-1
    if A[j] ≤ pivot
      A[i], A[j] = A[j], A[i]
      i += 1
    end
  end
  A[i], A[hi] = A[hi], A[i]
  return i
end

function quicksort_ip!(A::Array{Int}, lo::Int, hi::Int)
  if lo < hi
    p = partition!(A, lo, hi)
    quicksort_ip!(A, lo, p-1)
    quicksort_ip!(A, p+1, hi)
  end
end

println("Using quicksort alloc")
quicksort([2, 1, 3])
nums = rand(1:1_000_000, 1_000_000)
@time quicksort(nums)

println("Using quicksort in place")
quicksort_ip!([2,1,3])
nums = rand(1:1_000_000, 1_000_000)
@time quicksort_ip!(nums)

println("Using sort!")
sort!([2,1,3])
nums = rand(1:1_000_000, 1_000_000)
@time sort!(nums)

println("Using Julia quicksort")
sort!([2,1,3]; alg=QuickSort)
nums = rand(1:1_000_000, 1_000_000)
@time sort!(nums; alg=QuickSort)

# Using quicksort alloc
#  11.274339 seconds (86.80 M allocations: 3.113 GB, 3.67% gc time)
# Using quicksort in place
#   2.439658 seconds (23.70 M allocations: 1.231 GB, 4.25% gc time)
