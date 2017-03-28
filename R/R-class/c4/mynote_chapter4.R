##mynote 2017-3-28

iTotal <- 0
for(i in 1:100)
{
  iTotal <- iTotal + i
}
cat("Sum of 1-100:",iTotal,"\n",sep="")

szSymbols <- c("MSFT","GOOG","AAPL","INTL","ORCL","SYMC")
for(SymbolName in szSymbols)
{
  cat(SymbolName,"\n",sep="")
}

x <- matrix(1:6, 2, 3)
ifelse(x >= 0, sqrt(x), NA)
