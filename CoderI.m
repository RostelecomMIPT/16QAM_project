clc
clear all
Nfft = 1024; % ���-�� �������� �� ����� OFDM �� ��������� �������
Nc = 100; % ���-�� ������� � �������
Symbol = 1; %���-�� OFDM-��������
% dt = 1/1024; %����� �������������
Nsk = 16; % ����� ���������
DictCoord = [];% OFDM-������
%����������� "�������"
n=1;
%���������� ������ �� ��������� � ������ ������ ��� ���������
for k = 1:1:sqrt(Nsk)
    for j = 1:1:sqrt(Nsk)
            DictCoord(n) = (2*k-1-sqrt(Nsk)) + (2*j-1-sqrt(Nsk))*1i;
            n=n+1;
    end
end

%qammod !!!!!!!!!!
%�������� ������ �� �������� �������������������, � ����������� ����������
%�-�� ������������ ��������� ValDictCoord
DictNumb = {'1  1  0  0', '1  1  0  1', '1  0  0  1', '1  0  0  0', ...
            '1  1  1  0', '1  1  1  1', '1  0  1  1', '1  0  1  0',...
            '0  1  1  0', '0  1  1  1', '0  0  1  1', '0  0  1  0', ...
            '0  1  0  0', '0  1  0  1', '0  0  0  1', '0  0  0  0' };
%������ �������� ��� ���������
BeginBits = randi([0,1],1, (Nc*sqrt(Nsk)*Symbol));
%randomize
RandBits = randi([0,1],1,(Nc*sqrt(Nsk)*Symbol));
%��������� ������������ � ������� ������������������
for k = 1:1:(Nc*sqrt(Nsk)*Symbol)
        BeginBits(k) = xor(BeginBits(k),RandBits(k));
end

%���� ������� � ��������������� ������������������ �� 4
k = 1;

for j=1:4:Nc*Symbol*sqrt(Nsk)
        GroupBits(:,k) = deblank((...
            cellstr(...
            num2str(...
            BeginBits(j:(j+sqrt(Nsk)-1))))));
        k = k + 1;
end
%������������ ������ ��� ����� � ������� ��� �� ������� � ��������� ��
%���������� � ������ ���������
%strcmp - ������� ��������� �����. � ������ ������ ������������ ������ ��
%������� � �������� �� �������������� ��� �� 4
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
%��������� ��������� �����������, �.�. ����������� ���� ������� ������ ��
%Nfft/2-1 ������, � ������ ���� � ���������� ����������� � �����������
%����������� ������: (3+3�, 3+1�, 0,0,0, 3-1�, 3-3�) "�+�I"
%� ��� 511 ������� ������� � 100 ����� ������� -> ���� ��������� 
%�� 101 �� 511 ��������� ������ 
%_______________
%����������� ������, �� �������, ��� �� ���� �������������� + 
%������ ����� �� ������� �������(������ ������� = 0 � ����������� ��
%���������� ��������-OFDM). �� ��������� ������������ �� �� 1 �� 1023, � ��
%2 �� 1023. � ������ ������� ������, �� � ����� ����� �� �������
%����������.
for k = 1:1:Symbol
    MedSignalFSymm(k,:) = (wrev(MedSignalF(k,:)))'; 
end
zeroo = zeros (Symbol, Nfft - 2*(Nc+1)+1);
SignalF = [zeros(Symbol,1) ,...
            MedSignalF,...
            zeroo,...
            MedSignalFSymm];
%������� ������ � �����, ��� ��������������� �������
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
%��������, �����������
%���������� ���-�� �������� � �������
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
            if ((real(DeSignalInF(k)) - real(DictCoord(l))<0.0001)...%������������� � ������� ��������
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

% ���� ������� = -atan(x/y);
% ��������� ������� = abs(x+yI);