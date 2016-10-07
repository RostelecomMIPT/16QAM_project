function [ MER ] = MerFunction( DeSignalF,Nsk,Nfft )
    %MER = 10 * log10 (SUM (I^2 + Q^2)/SUM(dI^2+dQ^2))
    %Найти вектор ошибок *
    % входное:
    %фурье-образ только информативных несущих
    % + Созвездие + сгенерить взможные координаты
    n = 1;
    for k = 1 : 1 : sqrt(Nsk)
        for l = 1 : 1 : sqrt(Nsk)
            Ideal (n) = complex((2*k-1-sqrt(Nsk)), (2*l-1-sqrt(Nsk)));
            n = n + 1;
        end
    end
    Ideal(n) = 0;
    DeSignalF = DeSignalF .* sqrt(Nfft);
    for k = 1:length(DeSignalF)
        [dErrorVector(k), dErrorIndex(k)] = min(ones(1,n).*DeSignalF(k) - Ideal);
    end
    MedSumUp = sum( abs(Ideal(dErrorIndex)).^2 );
    MedSumDown = sum( abs(dErrorVector).^2 );
    MER = 10 * log10 (MedSumUp/MedSumDown);
end

