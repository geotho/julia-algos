using Hurricane
using MacroTools


function fib(n)

  if n ≤ 2
    return 1
  end

  return @join @go(fib(n-2)) + @go(fib(n-1))
end

for i in 1:10
  @show fib(i)
end
