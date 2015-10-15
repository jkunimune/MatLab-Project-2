%plotExhaustCooling.m
 format long;
 ouptut = simulateExhaustCooling();
 T = output(:,1);
 Ufluid = output(:,2);
 Ucabin = output(:,3);
 
 plot(T,Ufluid,T,Ucabin);