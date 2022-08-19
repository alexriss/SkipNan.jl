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

    x2 = skipnan([1. 2. 3.; 4. NaN 5.])
    @test x2[2,3] ≈ 5.
    err = nothing
    try
        x2[2,2]
    catch err
    end
    @test isa(err, MissingException)
    @test contains(sprint(showerror, err), "missing")

    @test sprint(Base.show, x) == "skipnan([1.0, NaN, 2.0])"
    @test [i for i in x] ≈ [1., 2.]
    typeof(eachindex(x)) <: Base.Iterators.Filter
    @test collect(eachindex(x)) ≈ [1, 3]
    @test eltype(x) == Float64
    @test eltype(x32) == Float32
    @test Base.IteratorSize(x) == Base.SizeUnknown()
    @test Base.IndexStyle(typeof(x)) == Base.IndexLinear()

    @test isequal(Base.parent(x), [1., NaN, 2.])
    @test isequal(Base.parent(x32), Float32[1f0, NaN32, 2f0])
end
