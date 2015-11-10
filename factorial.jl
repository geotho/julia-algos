using Hurricane

function fact(n::Int)
  info("N = $n")
  if n ≤ 1
    return 1
  end

  @join begin
    nminusone = @go(fact(n-1))
  end
  return n * nminusone
end

@show fact(3)
