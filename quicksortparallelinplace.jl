using Hurricane

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
    @join begin
      @go quicksort_ip!(A, lo, p-1)
      @go quicksort_ip!(A, p+1, hi)
    end
  end
end

arraylength = 1_000_000

println("Using quicksort in place")
quicksort_ip!([2,1,3])
nums = rand(1:1_000_000, arraylength)
@time quicksort_ip!(nums)

println("Using sort!")
sort!([2,1,3])
nums = rand(1:1_000_000, arraylength)
@time sort!(nums)

println("Using Julia quicksort")
sort!([2,1,3]; alg=QuickSort)
nums = rand(1:1_000_000, arraylength)
@time sort!(nums; alg=QuickSort)

# Using quicksort in place
#  26.123049 seconds (37.13 M allocations: 2.874 GB, 60.48% gc time)
# Using sort!
#   0.093997 seconds (4 allocations: 160 bytes)
# Using Julia quicksort
#   0.083541 seconds (5 allocations: 240 bytes)
