function [ DeBits ] = DeMapper( DeSignalInFUse,Nc ,Nsk )
    n = 1;
    for k = 1 : 1 : sqrt(Nsk)
        for l = 1 : 1 : sqrt(Nsk)
            Ideal (n) = complex((2*k-1-sqrt(Nsk)), (2*l-1-sqrt(Nsk)));
            n = n + 1;
        end
    end
    Dictionary2 = [1 1 0 0;...
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
    Dictionary2 = Dictionary2';
    Dictionary = [Dictionary1Re; Dictionary1Im ; Dictionary2];
DeBits = [];
DeNumbOFDM=length(DeSignalInFUse)/Nc;
for n=1:Nc*DeNumbOFDM
    for l=1:Nsk
            if ((abs(real(DeSignalInFUse(n)) - Dictionary(1,l))<0.0001)...%������������� � ������� ��������
              &&abs(imag(DeSignalInFUse(n)) - Dictionary(2,l))<0.0001)
                DeBits = [DeBits (Dictionary(3:6,l))'];
                break;
            end
    end
end

end

