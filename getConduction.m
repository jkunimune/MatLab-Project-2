function [ conductionHeatFlow ] = getConduction(k, A, d, T1, T2)
    conductionHeatFlow = (k*A/d)*(T1 - T2);
end