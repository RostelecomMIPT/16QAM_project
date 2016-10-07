function [ DeSignalInFUse, DeSignalF ] = DeModulator( SignalOut,Nfft,Nc)
DeNumbOFDM = length(SignalOut)/Nfft ;%+ Nfft/8
    DeSignalF = [];
    for k = 0:(DeNumbOFDM - 1)
        DeSignalF = [DeSignalF, fft(SignalOut(1 + k*Nfft : Nfft + Nfft*k))];
        %fft(DeSignalBySymbol(n,Nfft/8+1:((Nfft + Nfft/8))), Nfft);
    end
    DeSignalInFUse=[];
    for k = 0:(DeNumbOFDM - 1)
        DeSignalInFUse = [DeSignalInFUse, DeSignalF(2 + k*Nfft : ...
                                                    Nfft*k + Nc + 1)];
    end
end

