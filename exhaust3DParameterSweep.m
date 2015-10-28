%exhaust3DParameterSweep.m
%sweeps 3D exhaust paramaters.

format long;
 
conductionCoefficient = linspace(100,500,30);%W/m^2K
outsideTemps = linspace(273-70,15+273,30);%K

avgTemps = zeros(length(conductionCoefficient),length(outsideTemps));
for n = 1:length(conductionCoefficient)
    for m = 1:length(outsideTemps)
        timeSeries = simulateExhaustCooling(conductionCoefficient(n), outsideTemps(m));
        Tcabin = timeSeries(:,3);
        avgTemps(n,m) = median(Tcabin);
    end
end
 
pcolor(conductionCoefficient, outsideTemps-273, avgTemps - 273);
colorbar();
ylabel('Outside Temperature (^oC)');
xlabel('Conduction Coefficient (W/(m^2*K))');
title('Median Cabin Temperature for varying Insulation and Oustide Temperatures');