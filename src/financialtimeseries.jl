"""
Financial time series type that includes `TimeSeries.TimeArray` component
and instrument (stock, currency pair) metadata.
"""
type FinancialTimeSeries{T<:Float64, N, M<:Union(AbstractInstrument, AbstractCurrency)} <: AbstractTimeSeries
  series::TimeArray{T,N}
  instrument::M
end

function show(io::IO, fts::FinancialTimeSeries)
  # summary line: instrument type
  println(io, "")
  print(io, @sprintf("Financial time series for %s\n", string(typeof(fts.instrument))))
  println(io, "")
  # instrument
  Base.show(io, fts.instrument)
  println(io, "")
  # TimeArray
  Base.show(io, fts.series)
end

"""
FinancialTimeSeries type outer constructor with `TimeArray` components.
"""
function FinancialTimeSeries{T<:Float64, N}(timestamp::Union(Vector{Date}, Vector{DateTime}),
                                            values::Array{T,N},
                                            colnames::Vector{ASCIIString},
                                            instrument::Union(AbstractInstrument, AbstractCurrency))
  # utilize TimeArray inner-constructor checks
  return FinancialTimeSeries(TimeArray(timestamp, values, colnames), instrument)
end

"Access timestamp vector"
timestamp{T,N,M}(fts::FinancialTimeSeries{T,N,M}) = fts.series.timestamp

### this does not work either
#timestamp(fts::FinancialTimeSeries) = fts.series.timestamp

"Access values array"
values{T,N,M}(fts::FinancialTimeSeries{T,N,M}) = fts.series.values

"Access column names vector"
colnames{T,N,M}(fts::FinancialTimeSeries{T,N,M}) = fts.series.colnames

"Access instrument object"
instrument{T,N,M}(fts::FinancialTimeSeries{T,N,M}) = fts.instrument

"Returns, method string can be `simple` or `log`"
function percentchange{T,N,M}(fts::FinancialTimeSeries{T,N,M};
                              method = "simple")
  return percentchange(fts.series, method=method)
end

### TODO: wrappers for extracting column by string etc.
