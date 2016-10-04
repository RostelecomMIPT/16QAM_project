function [ MER ] = MerFunction( DeSignalInF,Nsk )
    %MER = 10 * log10 (SUM (I^2 + Q^2)/SUM(dI^2+dQ^2))
    %����� ������ ������ *
    %1) ����� ������ ������ *
    %2) ���������� ������� �� �������, �� ������ �� �����, ��� ���������� *
    %2.1) ������� �� ��������� *
    %2.2) ������� �� ���������� *
    %2.3) ������� �� ��������� ��������� ������ ���������� *
    %3) ����� ������� ��-������ � ��-������ *
    %4) ��������� ��� �� ������� ����
    % �������:
    %����� ����� ���� + ��������� + ��������� �������� ����������
    % ��������� ��������� ��������� �� ���������
    n = 1;
    dError = [];
    for k = 1 : 1 : sqrt(Nsk)
        for l = 1 : 1 : sqrt(Nsk)
            Ideal(1,n) = (2*k-1-sqrt(Nsk));
            Ideal(2,n) = (2*l-1-sqrt(Nsk));
            n = n + 1;
        end
    end
    % ������� �� ����������
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

