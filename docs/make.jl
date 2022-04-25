using SkipNan
using Documenter

DocMeta.setdocmeta!(SkipNan, :DocTestSetup, :(using SkipNan); recursive=true)

makedocs(;
    modules=[SkipNan],
    authors="Alex Riss <00alexx@riss.at> and contributors",
    repo="https://github.com/alexriss/SkipNan.jl/blob/{commit}{path}#{line}",
    sitename="SkipNan.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://alexriss.github.io/SkipNan.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/alexriss/SkipNan.jl",
    devbranch="main",
)
