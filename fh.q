/ Connect to the tickerplant running on port 5010
h:hopen 5010;

/ 
Generate and publish a batch of simulated trade data every 5 seconds.
The data contains timestamps, symbols, prices, sizes and trade sides.
\

.z.ts:{

  / Generate three timestamps using the current time
  times: 3#.z.n;
  
  / Randomly select three symbols from the available instruments
  syms: 3?`TSLA`MSFT`AAPL;

  / Generate three random trade prices
  prices: 3?10000.0;

  / Generate three random integer trade sizes
  sizes: 3?100i;

  / Randomly select buy or sell trade sides
  sides: 3?`B`S;

  / Send the generated trade batch to the tickerplant
  neg[h](`.u.upd;`trades; (times; syms; prices; sizes; sides));}

/ Set the timer to trigger .z.ts every 5000 milliseconds
system "t 5000";