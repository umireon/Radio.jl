abstract Modem
abstract CodingScheme


type Gray <: CodingScheme end


function encode( ::Type{Gray}, n::Integer )
    n $ (n >> 1)
end

encode{T<:CodingScheme}( ::Type{T}, N::AbstractVector ) = [ encode( T, n) for n in N ]

function decode( ::Type{Gray}, n::Integer )
    p = n
     while (n >>= 1) != 0
         p $= n
     end
     return p
end

decode{T<:CodingScheme}( ::Type{T}, N::AbstractVector ) = [ decode( T, n) for n in N ]



type PSKModem
    M::Integer                     # Modulation order, or bits per symbol. The constellation has M^2 symbols
    constellation::Vector{Complex} # ideal symbol constellation
end

function PSKModem( M::Integer )
    ispow2( M ) || error( "M must be a power of 2" )
    Δ𝜙            = 2π/M
    constellation = [ exp(Δ𝜙*im*i) for i in 0: M-1 ]
    PSKModem( M, constellation )
end


function symbol2index( symbol::Complex, constellationSize::Integer )
    ϕ = angle( symbol )

    if ϕ < 0
        ϕ += 2*pi
    end
    
    α = (constellationSize)/(2*pi)
    
    index = int(α * ϕ) + 1
    
    index = index > constellationSize ? 0 : index
    return index
end

function modulate( modem::PSKModem, bits::Integer )
    modem.constellation[decode( Gray, bits )+1]
end

function modulate( modem, data::AbstractVector )
    [ modulate( modem, datum ) for datum in data ]
end


function demodulate( modem::PSKModem, symbol::Complex )
    ϕ = angle( symbol )
    ϕ = ϕ < 0 ? ϕ += 2π : ϕ
    
    bits = int( ϕ*modem.M / 2π )
    encode( Gray, bits )
end

function demodulate( modem, symbols::AbstractVector{Complex} )
    [ demodulate( modem, symbol ) for symbol in symbols ]
end




#=

modem   = PSKModem( 16 )
data    = [0:modem.M-1]
symbols = modulate( modem, data)
scatter( symbols, "o", xlabel="I", ylabel="Q" )
demodulate( modem, symbols )

=# 