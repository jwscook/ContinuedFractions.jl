using ContinuedFractions, Test

@testset "Continued Fraction" begin
  @test sqrt(2) ≈ continuedfraction(i -> i == 0 ? 1 : 2, x->1, 20)
  # https://oeis.org/A003417
  arrayexp1 = [2, 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, 1, 1]
  fexp1(i) = arrayexp1[i + 1]
  @test exp(1) ≈ continuedfraction(fexp1, x->1, length(arrayexp1) - 1)
  # https://oeis.org/A001203
  arrayπ = [3, 7, 15, 1, 292, 1, 1, 1, 2, 1, 3]
  fπ(i) = arrayπ[i + 1]
  @test Float64(π) ≈ continuedfraction(fπ, x->1, length(arrayπ) - 1)

  for i ∈ 1:10
    atol, rtol =10.0^-rand(1:15), 10.0^-rand(1:15)
    answer = 1.61803398874989484820
    output = continuedfraction(i->1, x->1; atol=atol, rtol=rtol)[1]
    @test isapprox(answer, output, atol=atol, rtol=rtol)
    answer = sqrt(2)
    output = continuedfraction(i->i==0 ? 1 : 2, x->1; atol=atol, rtol=rtol)[1]
    @test isapprox(answer, output, atol=atol, rtol=rtol)
  end

end


