function [ SignalOut ] = Modul( MedSignalInF , NumbSymbol, Nc, Nfft, SNR )
    for k = 1:NumbSymbol
        MedSignalInFBySymbol(k,:) = MedSignalInF(((k-1)*Nc+1):k*Nc);
    end
    for k = 1:1:NumbSymbol
        MedSignalFSymm(k,:) = (wrev(MedSignalInFBySymbol(k,:)))'; 
    end
    zeroo = zeros (NumbSymbol, Nfft - 2*(Nc+1)+1);
    SignalF = [zeros(NumbSymbol,1) ,...
                MedSignalInFBySymbol,...
                zeroo,...
                MedSignalFSymm];
    %Готовый сигнал в фурье, для действительного сигнала(выше)
    for k = 1:1:NumbSymbol
        Signal(k,:) = ifft(SignalF(k,:));
    end
    %далее добавляем защитный интервал в наш сигнал
    SignalOut = [Signal(1,Nfft - Nfft/8 + 1:Nfft) Signal(1,:)];
    for k = 2:1:NumbSymbol
        SignalOut = [SignalOut Signal(k,Nfft - Nfft/8 + 1:Nfft)  Signal(k,:)];
    end
    %добавляем шум, на наши полезные интервалы.
%     SignaNoiseTu = NoiseSignalOutTu(Signal);
    Psignal = sum(SignalOut.^2,2)/length(SignalOut);
    Pnoise = Psignal/(10^(SNR/10));
    Sigma = sqrt(Pnoise);
    SignalNoiseTu = wgn(1,length(SignalOut), 10*log10(Pnoise));
    SignalOut = SignalOut + SignalNoiseTu;
    z = 0;
end

