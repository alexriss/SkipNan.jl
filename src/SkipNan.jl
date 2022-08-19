module SkipNan

export skipnan

"""
    skipnan(itr)
Return an iterator over the elements in `itr` skipping
[`NaN`](https://docs.julialang.org/en/v1/base/numbers/#Base.NaN) values,
analogous to [`skipmissing`](https://docs.julialang.org/en/v1/base/base/#Base.skipmissing).
The returned object can be indexed using indices of `itr` if the latter is indexable.
Indices corresponding to missing values are not valid: they are skipped by
[`keys`](https://docs.julialang.org/en/v1/base/collections/#Base.keys)
and [`eachindex`](https://docs.julialang.org/en/v1/base/arrays/#Base.eachindex),
and a `MissingException` is thrown when trying to use them.
Use [`collect`](https://docs.julialang.org/en/v1/base/collections/#Base.collect-Tuple{Any})
to obtain an `Array` containing the non-`missing` values in
`itr`. Note that even if `itr` is a multidimensional array, the result will always
be a `Vector` since it is not possible to remove NaNs while preserving dimensions
of the input.
# Examples
```jldoctest
julia> x = skipnan([1., NaN, 2.])
skipnan([1.0, NaN, 2.0])
julia> sum(x)
3.0
julia> x[1]
1.0
julia> x[2]
ERROR: MissingException: the value at index (2,) is missing
[...]
julia> argmax(x)
3
julia> collect(keys(x))
2-element Vector{Int64}:
 1
 3
julia> collect(skipnan([1., NaN, 2.]))
2-element Vector{Float64}:
 1.0
 2.0
julia> collect(skipnan([1. NaN; 2. NaN]))
2-element Vector{Float64}:
 1.0
 2.0
```
"""
skipnan(itr) = SkipNaN(itr)

struct SkipNaN{T}
    x::T
end
Base.IteratorSize(::Type{<:SkipNaN}) = Base.SizeUnknown()
Base.IteratorEltype(::Type{SkipNaN{T}}) where {T} = Base.IteratorEltype(T)
Base.eltype(::Type{SkipNaN{T}}) where {T} = Base.eltype(T)
Base.parent(itr::SkipNaN) = itr.x

function Base.iterate(itr::SkipNaN, state...)
    y = iterate(itr.x, state...)
    y === nothing && return nothing
    item, state = y
    while isnan(item)
        y = iterate(itr.x, state)
        y === nothing && return nothing
        item, state = y
    end
    item, state
end

Base.IndexStyle(::Type{<:SkipNaN{T}}) where {T} = IndexStyle(T)
Base.eachindex(itr::SkipNaN) =
    Iterators.filter(i -> @inbounds(!isnan(itr.x[i])), eachindex(itr.x))
Base.keys(itr::SkipNaN) =
    Iterators.filter(i -> @inbounds(!isnan(itr.x[i])), keys(itr.x))
Base.@propagate_inbounds function Base.getindex(itr::SkipNaN, I...)
    v = itr.x[I...]
    isnan(v) && throw(MissingException("the value at index $I is missing"))
    v
end

function Base.show(io::IO, s::SkipNaN)
    print(io, "skipnan(")
    show(io, s.x)
    print(io, ')')
end

end
