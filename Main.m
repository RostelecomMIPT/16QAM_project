script
clc;
clear all;
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
NumbSymbol = 10;
rng(0);
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk);
SignalOut = Modul( MedSignalInF , NumbSymbol, Nc, Nfft );
SignalOutWN=NoizeGen(SignalOut);


plot(SignalOutWN,'r')
hold on
plot(SignalOut,'b')

FunctionOfCorrelation = FuncCorrelation(SignalOut,Nfft);
FunctionOfCorrelationWN = FuncCorrelation(SignalOutWN,Nfft);
%a=Midle(FunctionOfCorrelation);
figure
  plot(FunctionOfCorrelationWN,'r')
  hold on
  plot(FunctionOfCorrelation,'b');
   

%    plot(a,FunctionOfCorrelation(a),'*')
%     hold on
%     stem(a,FunctionOfCorrelation(a))

%DeSignalInF =DeModulator(SignalOut,Nfft,Nc);
% scatterplot(DeSignalInF)
% figure;
%  plot(abs(DeSignalInF));
%  figure;
%DeBits = DeMapper(MedSignalInF,Nc,Nsk );
%FinalBits = RSLOS(DeBits, Register);
%  plot(xor(FinalBits,InputBits));