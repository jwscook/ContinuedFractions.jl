module ContinuedFractions
"""
Calculate the continued fraction until convergence against specified tolerance
∑ᵢ uᵢ/vᵢ = v(0) + u(1) / (v(1) + u(2) / (v(2) + u(3)/(v(3) + ...)))
"""

export continuedfraction

"""
Calculate the continued fraction until convergence against specified tolerance
∑ᵢ uᵢ/vᵢ = v(0) + u(1) / (v(1) + u(2) / (v(2) + u(3)/(v(3) + ...)))
"""
function continuedfraction(v::V, u::U, atol=0,
    rtol=sqrt(eps(typeof(real(v(1) / u(1)))))
    ) where {V<:Function, U<:Function}
  n = 8
  a, b = continuedfraction(v, u, n, 2n)
  n *= 2
  while n <= 2^10
    isapprox(a, b, rtol=rtol, atol=atol) && return b, true
    a = deepcopy(b)
    n *= 2
    b = continuedfraction(v, u, n)
  end
  return b, isapprox(a, b, rtol=rtol, atol=atol)
end
function continuedfraction(v::V, u::U, n::Int, m::Int
    ) where {V<:Function, U<:Function}
  @assert m > n
  output_m = u(m) / v(m)
  for i ∈ reverse(n+1:m-1)
    output_m = u(i) / (v(i) + output_m)
  end
  ui, vi = u(n), v(n)
  output_m = ui / (vi + output_m)
  output_n = ui / vi
  for i ∈ reverse(1:n-1)
    ui, vi = u(i), v(i)
    output_m = ui / (vi + output_m)
    output_n = ui / (vi + output_n)
  end
  vi = v(0)
  return vi + output_n, vi + output_m
end
function continuedfraction(v::V, u::U, n::Int) where {V<:Function, U<:Function}
  output = u(n) / v(n)
  for i ∈ reverse(1:n-1)
    output = u(i) / (v(i) + output)
  end
  return v(0) + output
end

end
