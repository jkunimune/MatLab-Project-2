%PlotInsulationVsOutsideTemp.m

outsideTemps = linspace(200,15+273);
conductionCoefficients = zeros(1,length(outsideTemps));

for n = 1:length(outsideTemps)
    conductionCoefficients(n) = findInsulation(outsideTemps(n));
end

hold on;
plot(outsideTemps-273,conductionCoefficients);
plot([-80,20],[500,500],'--');

xlabel('Outside Temperature (^oC)');
ylabel('Conduction Coefficient (^W/_{(m^2*K)})');
title('Car Insulation Required to reach Room Temperature');

% ax1 = gca;
% ax1_pos = ax1.Position;
% ax2 = axes('Position',ax1_pos,...
%     'YAxisLocation','right');
% 
% ax = gca;
% ax.YTick = [500];
% ax.YTickLabel = {'Typical Car'};