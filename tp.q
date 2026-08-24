/ Tickerplant listens for IPC connections on port 5010
\p 5010

/ Create a daily tickerplant log file
.u.L:`$":tplog_",string .z.D;

/ Initialise the tickerplant log
.u.L set ();

/ Open the tickerplant log for writing
.u.l:hopen .u.L;

/ Store the list of subscribers for each table
.u.w:enlist[`trades]!()

/ 
Receive updates from the feedhandler, write them to the tickerplant
log and forward them to all subscribers.
\
.u.upd:{[t;x] 
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

