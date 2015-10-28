function [ output ] = simulateExhaustCooling(wallK, outsideTemp)
    
    %chosen
    engineEfficiency = 1/3;
    cabThickness = .1;%m
    
    fluidVol = .001;%m^3
    seconds = 30;
   
    %Fluid is in a aluminum container
    fluidContainerSurfaceArea = .1;%(m^2)
    fluidContainerThickness = .01;%m
    aluminumHeatTransferCoefficient = 200;%W/mK
    
    %Fluid and cabin start at room temperature
    fluidTempInit = 296;%K
    cabinTempInit = 296;%K
    
    
    % preexisting----------------------------------------------
    %We chose to use a nissan altima with a 2.5 liter 4-cylinder engine
    nissanAltimaEnginePower = 182; %hp
    horsepowerToWatts = 746;
    cabinVol = 3;%m^3
    %We are using water as our fluid
    waterDens = 1000;%kg/m^3
    waterSpecificHeat = 4186;%J/(kg*K)
    airDens = 1.225;%kg/m^3
    airSpecificHeat = 1000;%J/(kg*K)\
    
    %derived
    fluidMass = waterDens * fluidVol;
    airMass = airDens * cabinVol;
    exhaustPower = nissanAltimaEnginePower * horsepowerToWatts * (1 - engineEfficiency);
    cabinSurfaceArea = 6 * cabinVol^(2/3);
    
    [Time, Temperature] = ode45(@netFlows, [0,seconds], [fluidTempInit; cabinTempInit]);
    output = [Time Temperature];


    function flows = netFlows(~,Temperature)
        Tfluid_current = Temperature(1);
        Tair_current = Temperature(2);

        %convection = getConvection(convectConst,area,fluidT_current,cabinT_current);
        conduction1 = getConduction(aluminumHeatTransferCoefficient,fluidContainerSurfaceArea,fluidContainerThickness, Tfluid_current, Tair_current);
        conduction2 = getConduction(wallK,cabinSurfaceArea,cabThickness, Tair_current, outsideTemp);

        Ufluid_flow = (exhaustPower - conduction1);
        Uair_flow = (conduction1 - conduction2);
        
        Tfluid_flow = getTemperature(Ufluid_flow, fluidMass, waterSpecificHeat);
        Tair_flow = getTemperature(Uair_flow, airMass, airSpecificHeat);
        
        flows = [Tfluid_flow; Tair_flow];
    end
end


