%добавляем шум. Но только в интервалы с полезной инфой.

function [ SignaNoiseTu ] = NoiseSignalOutTu( Signal )
    SNR = 20; %соотношение сигнал-шум в дБ
    Mu = 0; % матожидание
    Psignal = sum(Signal.^2,2)/length(Signal);
    Pnoise = Psignal/(10^(SNR/10));
    Sigma = sqrt(Pnoise);
            % ниже сразу весь шум выходит в 1 строчку, в зависимости только
            % от отношения СНР
            % SignalNoise(k,t) = wgn(1,length(Signal),SNR);
    SignalNoise = normrnd(Mu, Sigma, 1, length(Signal));
    PnoiseAfter = sum(SignalNoise.^2,2)/length(Signal);
    SignaNoiseTu = SignalNoise(1,:);
    if (NumbSymbol > 1)       
        for k = 2:NumbSymbol
            SignaNoiseTu = [SignaNoiseTu SignalNoise(k,:)];
        end
    end
% проверка нашего шума через заданное соотношение мощностей
    MedConstanta = 10*log10(Psignal./PnoiseAfter);
end