%добавл€ем шум. Ќо только в интервалы с полезной инфой.

function [ SignaNoiseTu ] = NoiseSignalOutTu( Signal,NumbSymbol )
    SNR = 20; %соотношение сигнал-шум в дЅ
    Mu = 0; % матожидание
    Psignal = sum(Signal.^2,2);
    Pnoise = Psignal*10^(-SNR/10);
    Sigma = sqrt(Pnoise);
    for k = 1:NumbSymbol
        for t = 1:length(Signal)
            SignalNoise(k,t) = (1/(Sigma(k)*sqrt(2*pi)))*exp(-((t-Mu)^2)/(2*Sigma(k)));
        end
    end
    SignaNoiseTu = SignalNoise(1,:);
    if (NumbSymbol > 1)       
        for k = 2:NumbSymbol
            SignaNoiseTu = [SignaNoiseTu SignalNoise(k,:)];
        end
    end
% проверка нашего шума через заданное соотношение мощностей
end