/ RDB listens for client connections on port 5011
system"p 5011";

/ Load all schema definitions from schema.q
system"l schema.q";

/ Insert incoming tickerplant updates into the in-memory tables.
upd:{[t;d] t insert d};

/ Connect to the tickerplant on port 5010
.handles.tp:hopen 5010;
/ Connect to the HDB process on port 5012
.handles.hdb:hopen 5012

/ Subscribe to trade updates from the tickerplant
{.handles.tp(`.u.sub;x)} each tables[];

/ 
At end of day, persist the in-memory tables to the HDB,
clear the RDB table and signal the HDB process to reload.
\
.u.end:{[d]
  .Q.dpft[`:data/hdb;d;`sym;] each tables[];
  {delete from x} each tables[];
  .handles.hdb(".hdb.reload[]")};
