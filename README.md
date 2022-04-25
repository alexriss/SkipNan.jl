# SkipNan

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://alexriss.github.io/SkipNan.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://alexriss.github.io/SkipNan.jl/dev)
[![Build Status](https://github.com/alexriss/SkipNan.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/alexriss/SkipNan.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/alexriss/SkipNan.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/alexriss/SkipNan.jl)

## About

Use `skipnan` as you would use [`skipmissing`](https://docs.julialang.org/en/v1/base/base/#Base.skipmissing).

## Installation

SkipNan can be installed from the Julia package registry via:

```julia
using Pkg
Pkg.add("SkipNan")
```

## Use

```julia
using SkipNan
x = skipnan([1., NaN, 2.])

sum(x)  # 3.0
argmax(x)  # 3

collect(x)  # [1.0, 2.0]
collect(keys(x))  # [1, 3]

x[1]  # 1.0
x[3]  # 3.0
x[2]  # MissingException
```
