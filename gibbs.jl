# https://darrenjw.wordpress.com/2011/07/16/gibbs-sampler-in-various-languages-revisited/

using Distributions
using Gadfly

function gibbs(N=50000, thin=1000)
  x = 0.
  y = 0.
  xs = [0.]
  ys = [0.]
  for i = 1:N
    for _ = 0:thin
      x = rand(Gamma(3, 1.0/(y^2+4)))
      y = rand(Normal(1.0/(x+1), 1.0/(sqrt(2*x+2))))
    end
    # println(i," ", x," ", y)
    push!(xs, x)
    push!(ys, y)
  end

  @show length(xs)
  @show length(ys)
  @show length(0:50000)

  plot = Gadfly.plot(layer(x=1:100:50000, y=xs[1:100:50000], Geom.line),
                     layer(x=1:100:50000, y=ys[1:100:50000], Geom.line))

  Gadfly.draw(PDF("gibbs.pdf", 12cm, 6cm), plot)
end

@time gibbs()
