script
clc;
clear all;
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
NumbSymbol = 5;
LevelOfIncreasing = 3;
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk);
SignalOut = Modul( MedSignalInF , NumbSymbol, Nc, Nfft );
FunctionOfCorrelation = FuncCorrelation(SignalOut,Nfft);
plot(FunctionOfCorrelation);
PositionOfTs = PositionOfTs(FunctionOfCorrelation, LevelOfIncreasing, Nfft);
hold on;
plot(FunctionOfCorrelation(PositionOfTs),'*');
% a=Middle(FunctionOfCorrelation);
% plot(SignalOut);
%DeSignalInF =DeModulator(SignalOut,Nfft,Nc);
% scatterplot(DeSignalInF)
% figure;
%  plot(abs(DeSignalInF));
%  figure;
%DeBits = DeMapper(MedSignalInF,Nc,Nsk );
%FinalBits = RSLOS(DeBits, Register);
%  plot(xor(FinalBits,InputBits));