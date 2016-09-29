function [ SignalOut ] = Modul( MedSignalInF , NumbSymbol, Nc, Nfft )
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
    %������� ������ � �����, ��� ��������������� �������(����)
    for k = 1:1:NumbSymbol
        Signal(k,:) = ifft(SignalF(k,:));
        Pn(k) = abs()
    end
    %��������� ���, �� ���� �������� ���������.
    SignalOut
    %SNR = 20dB = 10 lg (Ps/Pn)
    %Pn = 
    %����� ��������� �������� �������� � ��� ������
    SignalOut = [Signal(1,Nfft - Nfft/8 + 1:Nfft) Signal(1,:)];
    for k = 2:1:NumbSymbol
        SignalOut = [SignalOut Signal(k,Nfft - Nfft/8 + 1:Nfft)  Signal(k,:)];
    end
end

