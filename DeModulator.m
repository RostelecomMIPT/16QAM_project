function [ DeSignalInF ] = DeModulator( SignalOut,Nfft,Nc)
DeNumbOFDM = length(SignalOut)/(Nfft + Nfft/8) ;
DeSignalBySymbol = [];
    for k = 0 :(DeNumbOFDM - 1)
        for l = 1 :(Nfft + Nfft/8 )
            DeSignalBySymbol(k+1,l) =  SignalOut(l + k*(Nfft + Nfft/8));
        end
    end
    for n=1:DeNumbOFDM
        DeSignalF(n,:) = fft(DeSignalBySymbol(n,Nfft/8+1:((Nfft + Nfft/8))), Nfft);
    end
DeSignalInF=[];
    for k=1:DeNumbOFDM
        DeSignalInF=[DeSignalInF DeSignalF(k,2:Nc+1)];
    end
end

