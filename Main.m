script
clc;
clear all;
<<<<<<< HEAD
%входные данные
=======
>>>>>>> refs/remotes/origin/master
Register = [1 0 0 1 0 1 0 1 0 0 0 0 0 0 0 ];
Nsk = 16;
Nfft = 1024;
Nc = 100;
<<<<<<< HEAD
NumbSymbol = 1;
LevelOfIncreasing = 3;
SNR = 30;
=======
NumbSymbol = 10;
>>>>>>> refs/remotes/origin/master
rng(0);
InputBits = randi([0,1],1,(Nc*sqrt(Nsk)*NumbSymbol));
%начала операций
Bits = RSLOS(InputBits, Register);
MedSignalInF = Mapper(Bits, Nsk);
<<<<<<< HEAD
SignalOut = Modul( MedSignalInF , NumbSymbol, Nc, Nfft, SNR);
% FunctionOfCorrelation = FuncCorrelation(SignalOut,Nfft);
% plot(FunctionOfCorrelation);
% for ShiftOnPositionOfTs = 2:1: NumbSymbol - 1
%     x = FunctionOfCorrelation((ShiftOnPositionOfTs-2)*(Nfft+(Nfft/8)) + Nfft/8:...
%                                 (ShiftOnPositionOfTs-1)*(Nfft+(Nfft/8)) + Nfft/8 - 1);
%      TS(ShiftOnPositionOfTs-1) = PositionOfTs(x, LevelOfIncreasing, Nfft);
%    hold on;
%     plot(((ShiftOnPositionOfTs-2)*(Nfft+Nfft/8) + TS(ShiftOnPositionOfTs-1)),...
%         FunctionOfCorrelation((ShiftOnPositionOfTs-2)*(Nfft+Nfft/8)+...
%         TS(ShiftOnPositionOfTs-1)),'*');
% end
[ DeSignalInFUse, DeSignalF ] = DeModulator(SignalOut,Nfft,Nc);
MER = MerFunction(DeSignalF, Nsk, Nfft);
% DeBits = DeMapper(DeSignalInFUse,Nc,Nsk );
% FinalBits = RSLOS(DeBits, Register);
% plot(xor(FinalBits,InputBits));
=======
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
>>>>>>> refs/remotes/origin/master
