using Hurricane

sleep(2)
# Hurricane.launch(1)

sleep(2)

@all function calcpi(i, step, n)
  sum = 0.0
  h = 1 / n
  for j in i:step:n
    x = (j-0.5)*h
    sum += 4./(1 + x^2)
  end
  return sum * h
end

sleep(2)

function dist_pi(n = 1_000_000_000)
  mypi = 0.0

  numpeers = Hurricane.npeers() + 1
  @show numpeers
  c = DChannel()

  for i in 1:100
    @go put!(c, calcpi(i, 100, n))
  end

  for i in 1:100
    mypi += take!(c)
  end

  print("pi is $mypi Error is $(abs(mypi-pi))\n")
end



dist_pi(10)
@time dist_pi()
@time dist_pi()
@time dist_pi()
@time dist_pi()
