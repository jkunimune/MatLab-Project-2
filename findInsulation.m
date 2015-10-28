function conductionCoefficient = findInsulation(outsideTemperature)
    conductionCoefficient = fzero(@getDiffFromRoomTemp, 300);
    
    function avgTemp = getDiffFromRoomTemp(conductionCoefficient)
        timeSeries = simulateExhaustCooling(conductionCoefficient, outsideTemperature);
        Tcabin = timeSeries(:,3);
        avgTemp = median(Tcabin)-293;
    end
end

