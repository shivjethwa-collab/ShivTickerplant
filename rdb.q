\p 5011

trades:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$();side:`symbol$())

upd:{[t;x] t insert x}

h:hopen 5010
h(`.u.sub;`trades)


hdbH:hopen 5012

.u.end:{[d]
  .Q.dpft[`:hdb;d;`sym;`trades];
  delete from `trades;
  hdbH "\\l ." }