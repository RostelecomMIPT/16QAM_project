function [ FunctionOfCorrelation ] = FuncCorrelation( SignalOut, Nfft )
    for k = 1 : (length(SignalOut) - Nfft - Nfft/8)
        MedFunction = 0;
        for l = 1 : (Nfft/8)
            MedFunction = MedFunction +...
                SignalOut(k + l - 1)*SignalOut(k + l + Nfft - 1);
        end
        FunctionOfCorrelation(k) = MedFunction;
    end
end