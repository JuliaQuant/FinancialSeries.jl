facts("constructors") do
  ticker_str = "TICKER"
#   context("inner constructor from TimeArray") do
#     fts = FinancialSeries.FinancialTimeSeries(
#       ohlc, FinancialSeries.Stock(FinancialSeries.Ticker(ticker_str)))
#     @fact values(fts.series["Open"])[1] => roughly(104.88)
#   end
#   context("from TimeArray components and instrument object") do
#     @fact_throws FinancialSeries.FinancialTimeSeries(
#       [DateTime(1795,10,31)], [0.0 0.0], ["col-1" "col-2"], "just-a-string")
#     fts = FinancialSeries.FinancialTimeSeries(
#       [DateTime(1795,10,31)], [0.0 0.0], ["col-1", "col-2"],
#       FinancialSeries.Stock(FinancialSeries.Ticker(ticker_str)))
#     @fact isa(fts.instrument, FinancialSeries.Stock) => true
#     @fact string(fts.instrument.ticker) => ticker_str
#   end

  ### TODO: redo these tests (or delete?) now that TimeArray has meta
  @fact 0 => 1
end

facts("element and time series method wrappers") do
  inst = FinancialSeries.Stock(FinancialSeries.Ticker("AAPL"))
  fts_cl = FinancialSeries.FinancialTimeSeries(cl, inst)
  fts_ohlc = FinancialSeries.FinancialTimeSeries(ohlc, inst)
#   context("element wrappers isolate elements") do
#     # correct types
#     @fact isa(timestamp(fts_cl), Array{Date,1}) => true
#     @fact isa(values(fts_cl), Array{Float64,1}) => true
#     @fact isa(values(fts_ohlc), Array{Float64,2}) => true
#     @fact isa(colnames(cl), Array{UTF8String, 1}) => true
#     @fact isa(instrument(fts_cl), FinancialSeries.Stock) => true
#     # proper indexing
#     @fact values(fts_cl)[2] => roughly(102.5)
#     @fact timestamp(fts_cl)[3] => DateTime.Date(2000,1,5)
#   end

  ### TODO: fix wrapper functions
  @fact 0 => 1
end

facts("time series method wrappers") do
#   inst = FinancialSeries.Stock(FinancialSeries.Ticker("AAPL"))
#   fts_cl = FinancialSeries.FinancialTimeSeries(cl, inst)
#   context("correct simple return value") do
#     @fact percentchange(fts_cl).values[1] => roughly((102.5-111.94)/111.94)
#   end
#   context("correct log return value") do
#     @fact percentchange(fts_cl, method="log").values[1] => roughly(log(102.5) - log(111.94))
#   end

  ### TODO: fix wrapper functions

  ## TODO: add tests for preserving meta after percentchange etc. calls
  @fact 0 => 1
end
