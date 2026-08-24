/ RDB listens for client connections on port 5011
\p 5011

/ Initialise the in-memory trades table
trades:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$();side:`symbol$())

/ Insert incoming tickerplant updates into the in-memory trades table.
upd:{[t;x] t insert x}

/ Connect to the tickerplant on port 5010
h:hopen 5010

/ Subscribe to trade updates from the tickerplant
h(`.u.sub;`trades)

/ Connect to the HDB process on port 5012
hdbH:hopen 5012

/ 
At end of day, persist the in-memory trades table to the HDB,
clear the RDB table and signal the HDB process to reload.
\
.u.end:{[d]
  .Q.dpft[`:hdb;d;`sym;`trades];
  delete from `trades;
  hdbH "\\l ." }