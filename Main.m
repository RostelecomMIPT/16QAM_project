script
clc;
clear all;
%входные данные
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
NumbSymbol = 10;
LevelOfIncreasing = 3;
SNR = 0;
rng(0);
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
ShiftOnPositionOfTs = 2;
%начала операций
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk);
SignalOut = Modul( MedSignalInF , NumbSymbol, Nc, Nfft, SNR);
FunctionOfCorrelation = FuncCorrelation(SignalOut,Nfft);
plot(FunctionOfCorrelation);
PositionOfTs = PositionOfTs(FunctionOfCorrelation, LevelOfIncreasing, Nfft, ShiftOnPositionOfTs);
hold on;
plot((ShiftOnPositionOfTs-2)*(Nfft+Nfft/8)+PositionOfTs,...
    FunctionOfCorrelation((ShiftOnPositionOfTs-2)*(Nfft+Nfft/8)+PositionOfTs),'*');
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