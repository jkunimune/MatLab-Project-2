%plotExhaustCooling.m
 format long;
 
 wallK = 30 / 0.1;%W/mK
 outsideTemp = 273;%K

 output = simulateExhaustCooling(wallK, outsideTemp);
 time = output(:,1);
 Tfluid = output(:,2);
 Tcabin = output(:,3);
 
 median(Tcabin - 273)
 
 plot(time, Tfluid - 273,time,Tcabin - 273);
 legend('Fluid Temperature','Cabin Temperature');
 ylabel('Temperature (^oC)');
 xlabel('Time (s)');
 title('Reheating Uninsulated Car with Exhaust Energy');