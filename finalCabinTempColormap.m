%exhaust3DParameterSweep.m
%sweeps 3D exhaust paramaters.

format long;
 
conductionCoefficient = linspace(100,500,100);%W/m^2K
outsideTemps = linspace(273-70,15+273,100);%K

avgTemps = zeros(length(conductionCoefficient),length(outsideTemps));
for n = 1:length(conductionCoefficient)
    for m = 1:length(outsideTemps)
        timeSeries = simulateExhaustCooling(conductionCoefficient(n), outsideTemps(m));
        Tcabin = timeSeries(:,3);
        avgTemps(m,n) = median(Tcabin);
    end
end
 
pcolor(conductionCoefficient, outsideTemps-273, avgTemps - 273);
h = colorbar();
xlabel(h, 'Cabin Temperature (^oC)');
ylabel('Outside Temperature (^oC)');
xlabel('Conduction Coefficient (W/(m^2*K))');
title('Using Exhaust to Heat your Car in Cold Weather');

shading flat;
shading interp;