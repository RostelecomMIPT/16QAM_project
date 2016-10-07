function [ FunctionOfCorrelation ] = FuncCorrelation( SignalOut, Nfft )
    MedMax = length(SignalOut);
    SignalOut = [SignalOut zeros(1,2*Nfft)];
    for l = 1:MedMax
        NormaFirst = SignalOut(l)^2;
        NormaSecond = SignalOut(l + Nfft)^2;
        MedFunctionOfCorrelation(1) = SignalOut(l)...
                                          *SignalOut(l + Nfft);
        for k = 2:Nfft/16
            MedFunctionOfCorrelation(k) = SignalOut(l + k - 1)...
                                          *SignalOut(l + k + Nfft);
            NormaFirst = NormaFirst + SignalOut(l + k - 1)^2;
            NormaSecond = NormaSecond + SignalOut(l + k + Nfft)^2; 
        end
        FunctionOfCorrelation(l) = sum(MedFunctionOfCorrelation)/...
                                    sqrt((NormaFirst*NormaSecond));
    end
end