###########################  FinancialTimeSeries & TickData
 
#function show(io::IO, ft::Union(FinancialTimeSeries, TickData))
function show(io::IO, ft::FinancialTimeSeries)
  # variables 
  nrow          = size(ft.values, 1)
  ncol          = size(ft.values, 2)
  intcatcher    = falses(ncol)
  for c in 1:ncol
      rowcheck =  trunc(ft.values[:,c]) - ft.values[:,c] .== 0
      if sum(rowcheck) == length(rowcheck)
          intcatcher[c] = true
      end
  end
  spacetime     = strwidth(string(ft.timestamp[1])) + 3
  firstcolwidth = strwidth(ft.colnames[1])
  colwidth      = Int[]
      for m in 1:ncol
          push!(colwidth, max(strwidth(ft.colnames[m]), strwidth(@sprintf("%.2f", maximum(ft.values[:,m])))))
      end

  # summary line
  println(io,@sprintf("%dx%d FinancialTimeSeries: %s %s to %s", nrow, ncol, ft.metadata.ticker, string(ft.timestamp[1]), string(ft.timestamp[nrow])))
  println(io,"")

  # row label line
   print(io, ^(" ", spacetime), ft.colnames[1], ^(" ", colwidth[1] + 2 -firstcolwidth))

   for p in 2:length(colwidth)
     print(io, ft.colnames[p], ^(" ", colwidth[p] - strwidth(ft.colnames[p]) + 2))
   end
   println(io,"")
 
  # timesftmp and values line
    if nrow > 7
        for i in 1:4
            print(io, ft.timestamp[i], " | ")
        for j in 1:ncol
            intcatcher[j] ?
            print(io, rpad(iround(ft.values[i,j]), colwidth[j] + 2, " ")) :
            print(io, rpad(round(ft.values[i,j], 2), colwidth[j] + 2, " "))
        end
        println(io,"")
        end
        println(io,'\u22EE')
        for i in nrow-3:nrow
            print(io, ft.timestamp[i], " | ")
        for j in 1:ncol
            intcatcher[j] ?
            print(io, rpad(iround(ft.values[i,j]), colwidth[j] + 2, " ")) :
            print(io, rpad(round(ft.values[i,j], 2), colwidth[j] + 2, " "))
        end
        println(io,"")
        end
    else
        for i in 1:nrow
            print(io, ft.timestamp[i], " | ")
        for j in 1:ncol
            intcatcher[j] ?
            print(io, rpad(iround(ft.values[i,j]), colwidth[j] + 2, " ")) :
            print(io, rpad(round(ft.values[i,j], 2), colwidth[j] + 2, " "))
        end
        println(io,"")
        end
    end
end

########################### Instrument

function show(io::IO, c::CUSIP)
    print(io, @sprintf("%s", c.id))
end

function show(io::IO, c::ReutersID)
    print(io, @sprintf("%s", c.id))
end

function show(io::IO, c::BloombergID)
    print(io, @sprintf("%s", c.id))
end

function show(io::IO, t::Ticker)
    print(io, @sprintf("%s", t.id))
end

function show(io::IO, s::Stock)
    println(io, @sprintf("ticker:         %s", s.ticker))
#    println(io, @sprintf("cusip:          %s", s.cusip))
    println(io, @sprintf("currency:       %s", s.currency))
    println(io, @sprintf("tick:           %s", s.tick))
    println(io, @sprintf("multiplier:     %s", s.multiplier))
end

function show(io::IO, c::Currency)
    print(io, @sprintf("%s", c.origin))
end

function show(io::IO, c::CurrencyPair)
    print(io, @sprintf("%s/%s", string(c.baseside), string(c.quoteside)))
end
