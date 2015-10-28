%exhaustParameterSweep.m
%sweeps exhaust paramaters.

format long;
 
conductionCoefficient = linspace(100,500);%W/m^2K
outsideTemp = 273;%K

avgTemps = zeros(1, length(conductionCoefficient));
for n = 1:length(conductionCoefficient)
    timeSeries = simulateExhaustCooling(conductionCoefficient(n), outsideTemp);
    Tcabin = timeSeries(:,3);
    avgTemps(n) = median(Tcabin);
end
 
plot(conductionCoefficient, avgTemps - 273);
legend('Cabin Temperature');
ylabel('Temperature (^oC)');
xlabel('Conduction Coefficient (W/(m^2*K))');
title('Median Cabin Temperature for varying Insulation in Freezing Weather');