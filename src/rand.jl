## rand.jl.  Can we generate random GMMs and sample from them?
## (c) 2013--2014 David A. van Leeuwen

## This function initializes a random GMM, with random means and random covariances
## The variances are somewhat arbitrarily chosen.  This can certainly be improved.
function Base.rand(::Type{GMM}, ng::Int, d::Int; sep=2.0, kind=:full)
    μ = sep * randn(ng, d)
    if kind==:diag
        Σ = hcat([rand(Chisq(1.0), ng) for i=1:d]...)
    elseif kind == :full
        Σ = Array{eltype(FullCov{Float64})}(undef, ng)
        for i=1:ng
            T = randn(d,d)
            Σ[i] = cholinv(T' * T / d)
        end
    else
        error("Unknown kind")
    end
    w = ones(ng)/ng
    hist = [History("")]
#    hist = History(@sprintf("Generated random %s covariance GMM with %d Gaussians of dimension %d",
#                            kind, ng, d))
    GMM(w, μ, Σ, [hist], 0)
end

## local helper
function binsearch(x::T, a::Vector{T}) where {T}
    issorted(a) || error("Array needs to be sorted")
    mi = 1
    ma = length(a)
    if x < a[mi]
        return 0
    elseif x >= a[ma]
        return ma
    end
    while ma - mi > 1
        h = mi + div(ma-mi,2)
        if x > a[h]
            mi = h
        else
            ma = h
        end
    end
    return mi
end

forcesymmetric(c::Matrix) = (Symmetric(c))

## This function samples n data points from a GMM.  This is pretty slow, probably due to the array assignments.
function Base.rand(gmm::GMM, n::Int)
    x = Array{Float64}(undef, n, gmm.d)
    ## generate indices distriuted according to weights
    index::Vector{Int} = mapslices(findall, rand(Multinomial(1, gmm.w), n).!=0,
                                   dims=1)[:]
    gmmkind = kind(gmm)
    for i=1:gmm.n
        ind = findall(index.==i)
        nₓ = length(ind)
        if gmmkind == :diag
            x[ind,:] .= (vec(gmm.μ[i,:]) .+ vec(sqrt.(gmm.Σ[i,:])) .* randn(gmm.d, nₓ))' ## v0.5 arraymageddon
        elseif gmmkind == :full
            x[ind,:] .= rand(MvNormal(vec(gmm.μ[i,:]), forcesymmetric(covar(gmm.Σ[i]))), nₓ)'
        else
            error("Unknown kind")
        end
    end
    x
end
