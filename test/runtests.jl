using SkipNan
using Test

@testset "SkipNan.jl" begin
    x = skipnan([1., NaN, 2.])
    @test sum(x) ≈ 3.
    x32 = skipnan(Float32[1f0, NaN32, 2f0])
    @test sum(x32) ≈ 3f0

    @test argmax(x) ≈ 3.
    @test argmax(x32) ≈ 3.

    collect(keys(x)) == [1, 3]

    @test collect(skipnan([1., NaN, 2.])) ≈ [1., 2.]
    @test collect(skipnan([1. NaN; 2. NaN])) ≈ [1., 2.]

    @test collect(skipnan(Float32[1., NaN, 2.])) ≈ Float32[1., 2.]
    @test collect(skipnan(Float32[1. NaN; 2. NaN])) ≈ Float32[1., 2.]

    err = nothing
    try
        x[2]
    catch err
    end
    @test isa(err, MissingException)
    @test contains(sprint(showerror, err), "missing")

    err = nothing
    try
        x32[2]
    catch err
    end
    @test isa(err, MissingException)
    @test contains(sprint(showerror, err), "missing")

end
