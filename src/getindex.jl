###########################  FinancialTimeSeries & TickData
 
# single row
function getindex(ft::Union(FinancialTimeSeries, TickData), n::Int)
    isa(ft, FinancialTimeSeries) ?
    FinancialTimeSeries(ft.timestamp[n], ft.values[n,:], ft.colnames, ft.instrument) :
    TickData(ft.timestamp[n], ft.values[n,:], ft.colnames, ft.instrument) 
end

# range of rows
function getindex(ft::Union(FinancialTimeSeries, TickData), r::Range1{Int})
    isa(ft, FinancialTimeSeries) ?
    FinancialTimeSeries(ft.timestamp[r], ft.values[r,:], ft.colnames, ft.instrument) :
    TickData(ft.timestamp[r], ft.values[r,:], ft.colnames, ft.instrument)
end

# array of rows
function getindex(ft::Union(FinancialTimeSeries, TickData), a::Array{Int})
    isa(ft, FinancialTimeSeries) ?
    FinancialTimeSeries(ft.timestamp[a], ft.values[a,:], ft.colnames, ft.instrument) :
    TickData(ft.timestamp[a], ft.values[a,:], ft.colnames, ft.instrument)
end

# single column fty name 
function getindex(ft::Union(FinancialTimeSeries, TickData), s::ASCIIString)
    n = findfirst(ft.colnames, s)
    isa(ft, FinancialTimeSeries) ?
    FinancialTimeSeries(ft.timestamp, ft.values[:, n], ASCIIString[s], ft.instrument) :
    TickData(ft.timestamp, ft.values[:, n], ASCIIString[s], ft.instrument)
end

# array of columns fty name
function getindex(ft::Union(FinancialTimeSeries, TickData), args::ASCIIString...)
    ns = [findfirst(ft.colnames, a) for a in args]
    isa(ft, FinancialTimeSeries) ?
    FinancialTimeSeries(ft.timestamp, ft.values[:,ns], ASCIIString[a for a in args], ft.instrument) :
    TickData(ft.timestamp, ft.values[:,ns], ASCIIString[a for a in args], ft.instrument)
end

# single date
function getindex(ft::Union(FinancialTimeSeries, TickData), d::DateTime{ISOCalendar,UTC})
   for i in 1:length(ft)
     if [d] == ft[i].timestamp 
       return ft[i] 
     else 
       nothing
     end
   end
 end
 
# range of dates
function getindex(ft::Union(FinancialTimeSeries, TickData), dates::Array{DateTime{ISOCalendar,UTC},1})
  counter = Int[]
  for i in 1:length(dates)
    if findfirst(ft.timestamp, dates[i]) != 0
      push!(counter, findfirst(ft.timestamp, dates[i]))
    end
  end
  ft[counter]
end

#### DOESN"T WORK #########

function getindex(ft::Union(FinancialTimeSeries, TickData), r::DateTimeRange{ISOCalendar,UTC}) 
    ft[[r]]
end

# day of week
# getindex{T,N}(ft::Union(FinancialTimeSeries, TickData){T,N}, d::DAYOFWEEK) = ft[dayofweek(ft.timestamp) .== d]
