%��������� ���. �� ������ � ��������� � �������� �����.

function [ SignaNoiseTu ] = NoiseSignalOutTu( Signal )
    SNR = 20; %����������� ������-��� � ��
    Mu = 0; % �����������
    Psignal = sum(Signal.^2,2)/length(Signal);
    Pnoise = Psignal/(10^(SNR/10));
    Sigma = sqrt(Pnoise);
            % ���� ����� ���� ��� ������� � 1 �������, � ����������� ������
            % �� ��������� ���
            % SignalNoise(k,t) = wgn(1,length(Signal),SNR);
    SignalNoise = normrnd(Mu, Sigma, 1, length(Signal));
    PnoiseAfter = sum(SignalNoise.^2,2)/length(Signal);
    SignaNoiseTu = SignalNoise(1,:);
    if (NumbSymbol > 1)       
        for k = 2:NumbSymbol
            SignaNoiseTu = [SignaNoiseTu SignalNoise(k,:)];
        end
    end
% �������� ������ ���� ����� �������� ����������� ���������
    MedConstanta = 10*log10(Psignal./PnoiseAfter);
end