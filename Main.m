script
clc
%ProbaPera
absol=[1322 2323 232 23]
clear all
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
NumbSymbol = 10;
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk);
% plot(abs(MedSignalInF));
% figure;
SignalOut = Modul( MedSignalInF , NumbSymbol, Nc, Nfft );
FunctionOfCorrelation = FuncCorrelation(SignalOut,Nfft);
plot(FunctionOfCorrelation);
% plot(SignalOut);
DeSignalInF =DeModulator(SignalOut,Nfft,Nc);
% scatterplot(DeSignalInF)
% figure;
%  plot(abs(DeSignalInF));
%  figure;
DeBits = DeMapper(MedSignalInF,Nc,Nsk );
FinalBits = RSLOS(DeBits, Register);
%  plot(xor(FinalBits,InputBits));