\p 5010

.u.L:`$":tplog_",string .z.D;
.u.L set ();
.u.l:hopen .u.L;


.u.w:enlist[`trades]!()


.u.upd:{[t;x] 
    .u.l enlist (`upd;t;x);
    .u.w[t]@\:(`upd;t;x);
 }


.u.sub:{[t] .u.w[t],:neg .z.w;}


.z.pc:{.u.w:.u.w except\: neg x;} 

