function [ output ] = simulateExhaustCooling(fluidMass, fluidSpecificHeat, airMass, airSpecificHeat)
    
    %chosen
    exhaustPower = 100000;%W
    area = 0.1;%(m^2)
    dist = .01;%m
    k = 200;%W/mK
    fluidTempInit = 293;%K
    cabinTempInit = 293;%K
    outsdTemp = 273;%K
    cabArea = 10;%m2
    cabThickness = .1;%m
    wallK = 20;%W/mK
    seconds = 60;%60 * 60;
    
    %derived
    cabinInitialEnergy = getEnergy(cabinTempInit, airMass, airSpecificHeat);
    fluidInitialEnergy = getEnergy(fluidTempInit, fluidMass, fluidSpecificHeat);
    
    [T, U] = ode45(@netFlows, [0,seconds], [fluidInitialEnergy;cabinInitialEnergy]);
    output = [T U];


    function flows = netFlows(~,U)
        Ufluid_current = U(1);
        Uair_current = U(2);

        fluidT_current = getTemperature(Ufluid_current,fluidMass,fluidSpecificHeat);
        cabinT_current = getTemperature(Uair_current,airMass,airSpecificHeat);

        conduction1 = getConduction(k,area,dist, fluidT_current, cabinT_current);
        conduction2 = getConduction(wallK,cabArea,cabThickness, cabinT_current, outsdTemp);

        Ufluid_flow = (exhaustPower - conduction1);
        Uair_flow = (conduction1-conduction2);
        flows = [Ufluid_flow; Uair_flow];
    end
end


