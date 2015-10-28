%PlotInsulationVsOutsideTemp.m

outsideTemps = linspace(200,15+273);
conductionCoefficients = zeros(1,length(outsideTemps));

for n = 1:length(outsideTemps)
    conductionCoefficients(n) = findInsulation(outsideTemps(n));
end

plot(outsideTemps-273,conductionCoefficients);
xlabel('Outside Temperature (^oC)');
ylabel('Conduction Coefficient (^W/_{(m^2*K)})');