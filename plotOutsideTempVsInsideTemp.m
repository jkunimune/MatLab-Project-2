%plotOutsideTempvsInsideTemp

outsideTemps = linspace(200,15+273);
conductionCoefficient = 500;
cabinTemperature = zeros(1, length(outsideTemps));
for n = 1:length(outsideTemps)
    timeSeries = simulateExhaustCooling(conductionCoefficient, outsideTemps(n));
    Tcabin = timeSeries(:,3);
    cabinTemperature(n) = median(Tcabin);
end

plot(outsideTemps-273,cabinTemperature - 273);
xlabel('Outside Temperature (^oC)');
ylabel('Cabin Temperature (^oC)');
title('Cabin Temp vs. Outside Temp for ConductionCoefficient = 500')