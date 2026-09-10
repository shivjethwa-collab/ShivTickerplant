/ Tickerplant listens for IPC connections on port 5010
system"p 5010"

/ Load table definitions
system"l schema.q";

/ Create a daily tickerplant log file
.u.L:hsym `$"data/tplogs/tplog_",string .z.d;

/ Initialise the tickerplant log
.u.L set ();

/ Open the tickerplant log for writing
.u.l:hopen .u.L;

/ Store the list of subscribers for each table
.u.w:()!();


/ Track current day
.u.d:.z.d

/ EOD: notify subscribers, increment date, roll log
.u.endofday:{[]
  (neg union/[.u.w[;;0]])@\:(`.u.end; .u.d);
  .u.d+:1;
  hclose .u.l;
  .u.L:hsym `$"data/tplogs/tplog_",string .u.d;
  .u.L set ();
  .u.l:hopen .u.L; }


/ 
Receive updates from the feedhandler, write them to the tickerplant
log and forward them to all subscribers.
\
.u.upd:{[t;x] 
    if[.z.d > .u.d; .u.endofday[]];
    .u.l enlist (`upd;t;x);
    .u.w[t]@\:(`upd;t;x);
 }

/ 
Subscribe a client to updates for the requested table.
The client handle is added to the subscriber list.
\
.u.sub:{[t] .u.w[t],:neg .z.w;}

/ Remove a disconnected client from the subscriber list
.z.pc:{.u.w:.u.w except\: neg x;} 