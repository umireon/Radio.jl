#==============================================================================#
#                                  Upsample                                    #
#==============================================================================#
function upsample( x::Vector, L::Int )
    # TODO: add argument valdiation
    N = length( x )
    K = N*L
    
    h = similarzeros( x, K )
    
    for i = 1:N
       h[i*L-L+1] = x[i] 
    end
    
    return h
end

#==============================================================================#
#                                  Interpolate                                 #
#==============================================================================#
function interpolate( x::Vector, L::Int )
    # TODO: add argument valdiation
    N = length( x )
    K = N*L
    
    h = similarzeros( x, K )
    
    for i = 1:N
       h[i*L-L+1] = x[i] 
    end
    
    return h
end