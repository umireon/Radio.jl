export blackaman, hamming, hann, kaiser, rectangular

#==============================================================================#
#                                Blackman Window                               #
#==============================================================================#

function blackaman( n::Integer, N::Integer )
    α = 0.42
    β = 0.5
    α - β*cos(2*π*n/(N-1)) + (β-α)*cos(4*π*n/(N-1))
end

function blackaman( N::Integer )
    n = 0:N-1
    α = 0.42
    β = 0.5
    α - β*cos(2*π*n/(N-1)) + (β-α)*cos(4*π*n/(N-1))
end

#==============================================================================#
#                                Hamming Window                                #
#==============================================================================#

function hamming( n::Integer, N::Integer )
    α = 0.54
    β = 0.46 # 1 - α
    α - β*cos(2*π*n/(N-1))
end

function hamming( N::Integer )
    n = 0:N-1
    α = 0.54
    β = 0.46 # 1 - α
    α - β*cos(2*π*n/(N-1))
end

#==============================================================================# 
#                                  Hann Window                                 #
#==============================================================================#

function hann( n::Integer, N::Integer )
    α = 0.5
    β = 0.5
    α - β*cos(2*π*n/(N-1))
end

function hann( N::Integer )
    n = 0:N-1
    α = 0.5
    β = 0.5
    α - β*cos(2*π*n/(N-1))
end

#==============================================================================#
#                                Kaiser Window                                 #
#==============================================================================#

function kaiser( n::Integer, N::Integer, α::Real )
    β   = π*α
    num = besseli(0, β*sqrt(1-(2*n/(N-1)-1).^2))
    dem = besseli(0, β)
    num/dem
end

function kaiser( N::Integer, α::Real )
    n   = 0:N-1
    β   = π*α
    num = besseli(0, β*sqrt(1-(2*n/(N-1)-1).^2))
    dem = besseli(0, β)
    num/dem
end

#==============================================================================#
#                              Rectangular Window                              #
#==============================================================================#

function rectangular( n::Integer, N::Integer )
    1.0
end

function rectangular( N::Integer )
    ones( typeof(1.0), N )
end