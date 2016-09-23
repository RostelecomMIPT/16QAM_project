clc
clear all
Nfft = 1024; % кол-во отсчётов на сивол OFDM во временной области
Nc = 100; % кол-во несущих в символе
Symbol = 1; %кол-во OFDM-символов
% dt = 1/1024; %время дискритизации
Nsk = 16; % выбор созвездия
DictCoord = [];% OFDM-символ
%составление "словаря"
n=1;
%составляем массив из координат с мнимой частью для созвездия
for k = 1:1:sqrt(Nsk)
    for j = 1:1:sqrt(Nsk)
            DictCoord(n) = (2*k-1-sqrt(Nsk)) + (2*j-1-sqrt(Nsk))*1i;
            n=n+1;
    end
end

%qammod !!!!!!!!!!
%составим массив из двоичных последовательностей, с сохранением номирацией
%к-ая соотвествует номерации ValDictCoord
DictNumb = {'1  1  0  0', '1  1  0  1', '1  0  0  1', '1  0  0  0', ...
            '1  1  1  0', '1  1  1  1', '1  0  1  1', '1  0  1  0',...
            '0  1  1  0', '0  1  1  1', '0  0  1  1', '0  0  1  0', ...
            '0  1  0  0', '0  1  0  1', '0  0  0  1', '0  0  0  0' };
%Создаём бинарный код рандомный
BeginBits = randi([0,1],1, (Nc*sqrt(Nsk)*Symbol));
%randomize
RandBits = randi([0,1],1,(Nc*sqrt(Nsk)*Symbol));
%применяем рандомизатор к входной последовательности
for k = 1:1:(Nc*sqrt(Nsk)*Symbol)
        BeginBits(k) = xor(BeginBits(k),RandBits(k));
end

%бьём входную и преобразованную последовательность по 4
k = 1;

for j=1:4:Nc*Symbol*sqrt(Nsk)
        GroupBits(:,k) = deblank((...
            cellstr(...
            num2str(...
            BeginBits(j:(j+sqrt(Nsk)-1))))));
        k = k + 1;
end
%сопоставляем группы бит входа с группой бит из словаря и переводим на
%координаты в мнимой плоскости
%strcmp - функция сравнения строк. В данном случае сравнивается строка из
%словаря с массивом из сгруппированых бит по 4
for k = 0 :1:(Symbol - 1)
    for l = 1:1:Nc
        if (strcmp(GroupBits(Nc*k+l), DictNumb(1)))
            MedSignalF(k+1,l) = DictCoord(1);
        else
             for m = 2:1:Nsk
                if (strcmp(GroupBits(Nc*k+l), DictNumb(m)))
                MedSignalF(k+1,l) = DictCoord(m);
                end
            end
        end

    end
end
d=1;
%формируем частотную зависимость, т.е. достраиваем нашу функцию нулями до
%Nfft/2-1 нулями, а дальше берём и отображаем симметрично с комплексным
%сопряжением пример: (3+3и, 3+1и, 0,0,0, 3-1и, 3-3и) "х+уI"
%У нас 511 несущих масимум и 100 самих несущих -> надо дополнить 
%от 101 до 511 заполнить нулями 
%_______________
%достраиваем нулями, те несущие, что не были зайдествованны + 
%массив нулей на нулевой частоте(первая частота = 0 в зависимости от
%количества символов-OFDM). Но симметрия производится не от 1 до 1023, а от
%2 до 1023. В начале нулевой массив, но в конце фурье не нулевая
%компонента.
for k = 1:1:Symbol
    MedSignalFSymm(k,:) = (wrev(MedSignalF(k,:)))'; 
end
zeroo = zeros (Symbol, Nfft - 2*(Nc+1)+1);
SignalF = [zeros(Symbol,1) ,...
            MedSignalF,...
            zeroo,...
            MedSignalFSymm];
%Готовый сигнал в фурье, для действительного сигнала
for k = 1:1:Symbol
    Signal(k,:) = ifft(SignalF(k,:));
end
d=1;
% plot(abs(SignalF(1,:)));
% figure;
% plot(Signal(1,:));
SignalOut = Signal(1,:);
for k = 2:1:Symbol
    SignalOut = [SignalOut, Signal(k,:)];
end
% plot(Signal(1,:));
% figure;
% plot(Signal(2,:));
% figure;
%plot(SignalExit);
%_________________
%декоддер, демодулятор
%определяем кол-во символов в сигнале
 DeNumbOFDM = length(SignalOut)/Nfft;
 DeSignalBySymbol = [];
 for k = 0:1:(DeNumbOFDM - 1)
     for l = 1:1:Nfft
         DeSignalBySymbol(k+1,l) =  SignalOut(l+k*Nfft);
     end
 end
 for n=1:DeNumbOFDM
    DeSignalF(n,:) = fft(DeSignalBySymbol(n,:), Nfft);
 end
d=1;
DeSignalInF=[];
for k=1:DeNumbOFDM
    DeSignalInF=[DeSignalInF DeSignalF(k,2:Nc+1)];
end
a=[];
DeDictNumb = [1 1 0 0;...
              1 1 0 1;...
              1 0 0 1;...
              1 0 0 0;...
              1 1 1 0;...
              1 1 1 1;...
              1 0 1 1;...
              1 0 1 0;...
              0 1 1 0;...
              0 1 1 1;...
              0 0 1 1;...
              0 0 1 0;...
              0 1 0 0;...
              0 1 0 1;...
              0 0 0 1;...
              0 0 0 0];
DeBits = [];
for k=1:Nc*DeNumbOFDM
    for l=1:Nsk
            if ((real(DeSignalInF(k)) - real(DictCoord(l))<0.0001)...%декодирование с жестким решением
              &&(imag(DeSignalInF(k)) - imag(DictCoord(l)))<0.0001)
                DeBits(k,:) = DeDictNumb(l,:);
                break;
            end
    end
end
Final=[];
for k = 1:Nc*DeNumbOFDM
    Final = [Final DeBits(k,:)];
end
Error = xor(Final,BeginBits);
plot(Error)

% фаза сигнала = -atan(x/y);
% амплитуда сигнала = abs(x+yI);