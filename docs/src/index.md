```@meta
CurrentModule = SkipNan
```

# SkipNan

Documentation for [SkipNan](https://github.com/alexriss/SkipNan.jl).

## About

Use `skipnan` as you would use [`skipmissing`](https://docs.julialang.org/en/v1/base/base/#Base.skipmissing).

## Installation

SkipNan can be installed from the Julia package registry via:

```julia
using Pkg
Pkg.add("SkipNan")
```

# Use

```@repl
using SkipNan
x = skipnan([1., NaN, 2.])
sum(x)
collect(x)
collect(keys(x))
x[1]
x[3]
x[2]
```

## Reference

```@autodocs
Modules = [SkipNan]
```
