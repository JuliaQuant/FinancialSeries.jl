function byvolume{T,N}(f::TimeArray{T,N}, n::Int)

    x = f["Volume"].values
    increments = Int[]
    volumes = Int[]
    fm = 1; m = 1
    
    while  m < length(f)
        next_increment = findfirst(x->x > n,cumsum(x[fm:end]))
        push!(increments, next_increment)
        #push!(volumes, cumsum(x[fm:end]))
        push!(volumes, fm)
        fm += next_increment
        m  += 1
    end
    
    res = cumsum(increments[increments .!= 0])
    f[res] #, volumes[1:length(res)]
end
