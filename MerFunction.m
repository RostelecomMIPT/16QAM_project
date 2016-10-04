function [ MER ] = MerFunction( DeSignalInF,Nsk )
    %MER = 10 * log10 (SUM (I^2 + Q^2)/SUM(dI^2+dQ^2))
    %Найти вектор ошибок *
    %1) взять нужный образФ *
    %2) произвести разброс по словарю, но только по части, где координаты *
    %2.1) разброс по амплетуде *
    %2.2) разброс по квадрантам *
    %2.3) разброс по возможным множестав внутри квандранта *
    %3) взять разницу Ре-РеНаше и Мн-МнНаше *
    %4) посчитать МЕР по формуле выше
    % входное:
    %фурье образ НАШЕ + Созвездие + сгенерить взможные координаты
    % генерация возможных координат по созвездию
    n = 1;
    dError = [];
    for k = 1 : 1 : sqrt(Nsk)
        for l = 1 : 1 : sqrt(Nsk)
            Ideal(1,n) = (2*k-1-sqrt(Nsk));
            Ideal(2,n) = (2*l-1-sqrt(Nsk));
            n = n + 1;
        end
    end
    % Разброс по амплитудам
    for k = 1:1:length(DeSignalInF)
        for l = 1:1:Nsk
            if ((abs(abs(real(DeSignalInF(k))) - abs(Ideal(1,l))) < 1) && ...
                 (abs(abs(imag(DeSignalInF(k))) - abs(Ideal(2,l))) < 1))
                dError(1, k) = l;
                dError(2, k) = abs(real(DeSignalInF(k))) - abs(Ideal(1,l));
                dError(3, k) = abs(imag(DeSignalInF(k))) - abs(Ideal(2,l));
                break;
            end
        end
    end
    %MER = 10 * log10 (SUM (I^2 + Q^2)/SUM(dI^2+dQ^2))
    MedSumUp = 0;
    MedSumDown = 0;
    for k = 1:length(DeSignalInF)
        MedSumUp =  MedSumUp + ...
                    Ideal(1,dError(1, k))^2 + Ideal(2,dError(1, k))^2;
        MedSumDown = MedSumDown + ...
        dError(2, k)^2 + dError(3, k)^2;
    end
    MER = 10 * log10 (MedSumUp/MedSumDown);
end

