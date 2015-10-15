function [ output ] = simulateExhaustCooling()

    %chosen
    exhaustPower = 100000;%W
    area = 0.1;%(m^2)
    dist = .01;%m
    k = 200;%W/mK
    fluidVol = .001;%m^3
    cabinVol = 3;%m^3
    fluidTempInit = 293;%K
    cabinTempInit = 293;%K
    seconds = 60 * 60;
    timeStep = 1;

    %preexisting
    airDens = 1.225;%kg/m^3
    airSpecificHeat = 1000;%J/(kg*K)
    %We are choosing water as our fluid (for now)
    waterDens = 1000;%kg/m^3
    waterSpecificHeat = 4186;%J/(kg*K)

    %derived
    airMass = airDens * cabinVol;
    fluidMass = waterDens * fluidVol;
    airInitialEnergy = getEnergy(cabinTempInit, airMass, airSpecificHeat);
    fluidInitialEnergy = getEnergy(fluidTempInit, fluidMass, waterSpecificHeat);

    Ufluid = zeros(seconds / timeStep, 1);
    Uair = zeros(seconds / timeStep, 1);

    Ufluid_current = fluidInitialEnergy;
    Uair_current = airInitialEnergy;


    for t = 1 : seconds / timeStep
    Ufluid(t) = Ufluid_current;
    Uair(t) = Uair_current;

    fluidT_current = getTemperature(Ufluid_current,fluidMass,waterSpecificHeat);
    cabinT_current = getTemperature(Uair_current,airMass,airSpecificHeat);
    conduction = getConduction(k,area,dist, fluidT_current, cabinT_current);

    Ufluid_current = Ufluid_current + (exhaustPower - conduction)*timeStep;
    Uair_current = Uair_current + conduction*timeStep;
    end
    
    T = timeStep : timeStep : seconds;
    
    output = [T' Ufluid Uair];
end
