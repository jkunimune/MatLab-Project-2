function [ convectionHeatFlow ] = getConvection(h, A, T1, T2)
    convectionHeatFlow = (h*A)*(T1 - T2);
end