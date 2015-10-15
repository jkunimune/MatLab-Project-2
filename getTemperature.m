function [ Temperature ] = getTemperature(Energy, mass, specificHeat)
    Temperature = Energy./(mass * specificHeat);
end