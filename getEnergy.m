function [ Energy ] = getEnergy(Temperature, mass, specificHeat)
    Energy = Temperature.*(mass * specificHeat);
end