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
                MedSignalFSymm] / sqrt(Nfft);
%     PSignalInF = sum(abs(SignalF).^2, 2)/length(SignalF);
    %Готовый сигнал в фурье, для действительного сигнала(выше)
    for k = 1:1:NumbSymbol
        Signal(k,:) = ifft(SignalF(k,:));
    end
    PSignal = sum(abs(Signal).^2, 2);
%     далее добавляем защитный интервал в наш сигнал
    SignalOut = Signal(1,:); %[Signal(1,Nfft - Nfft/8 + 1:Nfft)...]
    for k = 2:1:NumbSymbol
        SignalOut = [SignalOut  Signal(k,:)]; %Signal(k,Nfft - Nfft/8 + 1:Nfft)
    end
    SignalOut = Signal(1,:);
    for k = 2:1:NumbSymbol
        SignalOut = [SignalOut Signal(k,:)];
    end
    %добавляем шум, на наши полезные интервалы.
%     SignaNoiseTu = NoiseSignalOutTu(Signal);
    Psignal = sum(SignalOut.^2);
%     Pnoise = Psignal/(10^(SNR/10));
%     Sigma = sqrt(Pnoise);
    SignalNoise = wgn(1,length(SignalOut), 10*log10(Psignal) - SNR)/sqrt(length(SignalOut));
     P1N = sum(SignalNoise.^2);
     P1S = sum(SignalOut.^2);
    SignalOut = SignalOut + SignalNoise;
     lll = 10*log10(P1S/P1N);
end

