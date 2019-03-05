function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    precompile(Tuple{typeof(GaussianMixtures.llpg), GaussianMixtures.GMM{Float64, Array{Float64, 2}}, Array{Float64, 2}})
    precompile(Tuple{typeof(GaussianMixtures.stats), GaussianMixtures.GMM{Float64, Array{Float64, 2}}, Array{Float64, 2}, Int64})
    precompile(Tuple{getfield(GaussianMixtures, Symbol("##stats#35")), Int64, Bool, typeof(identity), GaussianMixtures.GMM{Float64, Array{Float64, 2}}, Array{Float64, 2}})
    precompile(Tuple{getfield(GaussianMixtures, Symbol("##em!#14")), Int64, Float64, Int64, Int64, typeof(identity), GaussianMixtures.GMM{Float64, Array{Float64, 2}}, Array{Float64, 2}})
    precompile(Tuple{typeof(GaussianMixtures.sanitycheck!), GaussianMixtures.GMM{Float64, Array{Float64, 2}}})
    precompile(Tuple{typeof(GaussianMixtures.logsumexpw), Array{Float64, 2}, Array{Float64, 1}})
    precompile(Tuple{getfield(GaussianMixtures, Symbol("#kw##em!")), NamedTuple{(:nIter, :sparse), Tuple{Int64, Int64}}, typeof(GaussianMixtures.em!), GaussianMixtures.GMM{Float64, Array{Float64, 2}}, Array{Float64, 2}})
    precompile(Tuple{getfield(GaussianMixtures, Symbol("##GMMk#9")), Symbol, Int64, Int64, Int64, typeof(identity), Int64, Array{Float64, 2}})
    precompile(Tuple{typeof(GaussianMixtures.cholinv), Array{Float64, 2}})
    precompile(Tuple{typeof(GaussianMixtures.avll), GaussianMixtures.GMM{Float64, Array{Float64, 2}}, Array{Float64, 2}})
    precompile(Tuple{getfield(GaussianMixtures, Symbol("##GMM#8")), Symbol, Int64, Int64, Int64, Int64, Type{Int}, Int64, Array{Float64, 1}})
end
