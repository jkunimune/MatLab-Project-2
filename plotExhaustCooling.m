%plotExhaustCooling.m
 format long;
 
 %chosen
 fluidVol = .001;%m^3
 cabinVol = 3;%m^3

 %preexisting
 waterDens = 1000;%kg/m^3
 waterSpecificHeat = 4186;%J/(kg*K)
 airDens = 1.225;%kg/m^3
 airSpecificHeat = 1000;%J/(kg*K)
 
 %derived
 fluidMass = waterDens * fluidVol;
 airMass = airDens * cabinVol;
 
 output = simulateExhaustCooling(fluidMass, waterSpecificHeat, airMass, airSpecificHeat);
 time = output(:,1);
 Ufluid = output(:,2);
 Ucabin = output(:,3);
 
 Tfluid = getTemperature(Ufluid, fluidMass, waterSpecificHeat);
 Tcabin = getTemperature(Ucabin, airMass, airSpecificHeat);
 
 plot(time, Tfluid - 273,time,Tcabin - 273);
 legend('Fluid Temperature','Cabin Temperature');
 ylabel('Temperature (^oC)');
 xlabel('Time (s)');
 title('Reheating Car with Exhaust Energy');