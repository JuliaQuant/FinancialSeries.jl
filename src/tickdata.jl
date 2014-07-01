type TickData{T<:Float64,N}  <: AbstractTimeSeries

    timestamp::Vector{Date}
    values::Array{T,N}
    colnames::Vector{ASCIIString}
    instrument::AbstractInstrument

    function TickData(timestamp::Vector{Date}, 
                      values::Array{T,N},
                      colnames::Vector{ASCIIString},
                      instrument::AbstractInstrument)

                      v = findfirst(colnames .== "Volume") # first sort the values in ascending order
                      #vals = sortrows(values, by=x->x[v])
                      if v > 0 
                          vals = sortrows(values, by=x->x[v]) 
                      else
                          vals = values # don't sort if no Valume column available
                      end
                      nrow, ncol = size(values, 1), size(values, 2)
                      nrow != size(timestamp, 1) ? error("values must match length of timestamp"):
                      ncol != size(colnames,1) ? error("column names must match width of array"):
                      ~(flipud(timestamp) == sort(timestamp) || timestamp == sort(timestamp)) ? error("dates are mangled"):
                      flipud(timestamp) == sort(timestamp) ? 
                      new(flipud(timestamp), vals, colnames, instrument): # then the dates if necessary
                      new(timestamp, vals, colnames, instrument)
    end
end

TickData{T<:Float64,N}(d::Vector{Date}, v::Array{T,N}, c::Vector{ASCIIString}, t::AbstractInstrument) = TickData{T,N}(d,v,c,t)
TickData{T<:Float64,N}(d::Date, v::Array{T,N}, c::Array{ASCIIString,1}, t::AbstractInstrument) = TickData([d],v,c,t)

# ########################### TickData 
#  
# function show(io::IO, ft::TickData)
#   # variables 
#   nrow          = size(ft.values, 1)
#   ncol          = size(ft.values, 2)
#   intcatcher    = falses(ncol)
#   for c in 1:ncol
#       rowcheck =  trunc(ft.values[:,c]) - ft.values[:,c] .== 0
#       if sum(rowcheck) == length(rowcheck)
#           intcatcher[c] = true
#       end
#   end
#   spacetime     = strwidth(string(ft.timestamp[1])) + 3
#   firstcolwidth = strwidth(ft.colnames[1])
#   colwidth      = Int[]
#       for m in 1:ncol
#           push!(colwidth, max(strwidth(ft.colnames[m]), strwidth(@sprintf("%.2f", maximum(ft.values[:,m])))))
#       end
# 
#   # summary line
#   print(io,@sprintf("%dx%d %s %s to %s", nrow, ncol, typeof(ft), string(ft.timestamp[1]), string(ft.timestamp[nrow])))
#   println(io,"")
#   println(io,"")
# 
#   # row label line
#    print(io, ^(" ", spacetime), ft.colnames[1], ^(" ", colwidth[1] + 2 -firstcolwidth))
# 
#    for p in 2:length(colwidth)
#      print(io, ft.colnames[p], ^(" ", colwidth[p] - strwidth(ft.colnames[p]) + 2))
#    end
#    println(io,"")
#  
#   # timestamp and values line
#     if nrow > 7
#         for i in 1:4
#             print(io, ft.timestamp[i], " | ")
#         for j in 1:ncol
#             intcatcher[j] ?
#             print(io, rpad(iround(ft.values[i,j]), colwidth[j] + 2, " ")) :
#             print(io, rpad(round(ft.values[i,j], 2), colwidth[j] + 2, " "))
#         end
#         println(io,"")
#         end
#         println(io,'\u22EE')
#         for i in nrow-3:nrow
#             print(io, ft.timestamp[i], " | ")
#         for j in 1:ncol
#             intcatcher[j] ?
#             print(io, rpad(iround(ft.values[i,j]), colwidth[j] + 2, " ")) :
#             print(io, rpad(round(ft.values[i,j], 2), colwidth[j] + 2, " "))
#         end
#         println(io,"")
#         end
#     else
#         for i in 1:nrow
#             print(io, ft.timestamp[i], " | ")
#         for j in 1:ncol
#             intcatcher[j] ?
#             print(io, rpad(iround(ft.values[i,j]), colwidth[j] + 2, " ")) :
#             print(io, rpad(round(ft.values[i,j], 2), colwidth[j] + 2, " "))
#         end
#         println(io,"")
#         end
#     end
# end
