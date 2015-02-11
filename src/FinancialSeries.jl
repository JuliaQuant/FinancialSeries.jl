module FinancialSeries

# documentation
using Docile

if VERSION < v"0.4-"
  using Dates
else
  using Base.Dates
end
using Reexport
@reexport using TimeSeries

import Base: show, getindex

@document

export AbstractInstrument, AbstractCurrency, AbstractFinancialID,
       Stock, Currency, CurrencyPair,
       Ticker, CUSIP, BloombergID, ReutersID,
       FinancialTimeSeries,
       timestamp, values, colnames, instrument,
       TickData,
       USD, EUR, GBP, AUD, JPY, EURUSD, EURJPY, USDGBP, USDAUD, USDNZD, USDJPY, F, G, H, J, K, M, N, Q, U, V, X, Z,
       merge, parsedatetime, parsedatetime1, parsedatetime_from_TOS, makedatetime, datetolastsecond, discretesignal
       # yahoo, fred

include("instruments.jl")
include("financialtimeseries.jl")

#include("tickdata.jl")
#include("getindex.jl")
#include("utilities.jl")
#include("readwrite.jl")

end
