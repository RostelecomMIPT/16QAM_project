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
        Ideal (n) = complex((2*k-1-sqrt(Nsk)), (2*l-1-sqrt(Nsk)));
        n = n + 1;
    end
end

DeSignalInF = DeSignalInF .* sqrt(1024);
for k = 1:length(DeSignalInF)
    [dError(1,k), abs(dError(2,k))^2] = min(ones(1,Nsk).*DeSignalInF(k) - Ideal);
end
%MER = 10 * log10 (SUM (I^2 + Q^2)/SUM(dI^2+dQ^2))
MedSumUp = 0;
MedSumDown = 0;
for k = 1:length(DeSignalInF)
    MedSumDown = MedSumDown + dError(1,k);
    MedSumUp = MedSumUp + (abs(Ideal(abs(dError(2, k)))))^2;
end
MER = 10 * log10 (MedSumUp/MedSumDown);
%     MedSumUp = MedSumUp + ...
%                Ideal(1,dError(1, :)).^2 + Ideal(2,dError(1, :)).^2;
%     MedSumDown = MedSumDown + ...
%     dError(2, :).^2 + dError(3, :).^2;
%     MER = 10 * log10 (sum()/);
end

