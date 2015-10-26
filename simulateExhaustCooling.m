function [ output ] = simulateExhaustCooling(cabinSurfaceArea, fluidMass, fluidSpecificHeat, airMass, airSpecificHeat)
    
    %chosen
    %We chose to use a nissan altima 2.5 liter 4-cylinder engine for our
    %model
    nissanAltimaEnginePower = 182; %hp
    horsepowerToWatts = 746;
    engineEfficiency = 1/3;
    
    %Fluid is in a aluminum container
    fluidContainerSurfaceArea = .1;%(m^2)
    fluidContainerThickness = .01;%m
    aluminumHeatTransferCoefficient = 200;%W/mK
    
    %Fluid and cabin start at room temperature
    fluidTempInit = 296;%K
    cabinTempInit = 296;%K
    outsdTemp = 273;%K
    
    cabThickness = .1;%m
    wallK = 30;%51.8;%W/mK
    seconds = 60;
    
    %preexisting
    %convectConst = 100;%W/m2K
    
    %derived
    exhaustPower = nissanAltimaEnginePower * horsepowerToWatts * (1 - engineEfficiency);
    cabinInitialEnergy = getEnergy(cabinTempInit, airMass, airSpecificHeat);
    fluidInitialEnergy = getEnergy(fluidTempInit, fluidMass, fluidSpecificHeat);
    
    [T, U] = ode45(@netFlows, [0,seconds], [fluidInitialEnergy;cabinInitialEnergy]);
    output = [T U];


    function flows = netFlows(~,U)
        Ufluid_current = U(1);
        Uair_current = U(2);

        fluidT_current = getTemperature(Ufluid_current,fluidMass,fluidSpecificHeat);
        cabinT_current = getTemperature(Uair_current,airMass,airSpecificHeat);

        %convection = getConvection(convectConst,area,fluidT_current,cabinT_current);
        conduction1 = getConduction(aluminumHeatTransferCoefficient,fluidContainerSurfaceArea,fluidContainerThickness, fluidT_current, cabinT_current);
        conduction2 = getConduction(wallK,cabinSurfaceArea,cabThickness, cabinT_current, outsdTemp);

        Ufluid_flow = (exhaustPower - conduction1);
        Uair_flow = (conduction1-conduction2);
        flows = [Ufluid_flow; Uair_flow];
    end
end


