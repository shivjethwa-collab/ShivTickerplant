/ Initialise the in-memory trades table
trades:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$();side:`symbol$());

quotes:([]time:`timespan$();sym:`symbol$();bid:`float$();ask:`float$();bsize:`int$();asize:`int$());