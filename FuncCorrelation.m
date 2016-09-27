function [ FunctionOfCorrelation ] = FuncCorrelation( SignalOut, Nfft )
MultiplicationOfWindows = zeros(1, length(SignalOut) - Nfft);
FirstWindow = zeros(1, length(SignalOut) - Nfft);
SecondWindow = zeros(1, length(SignalOut) - Nfft);
FunctionOfCorrelation = zeros(1, length(SignalOut) - Nfft);
SignalOut = [SignalOut zeros(1,Nfft/16)]; 
   for k = 1 : (length(SignalOut) - Nfft)
       for l = 0 : ((Nfft/16)-1)
           MultiplicationOfWindows(k) = MultiplicationOfWindows(k)...
               + SignalOut(k + l)*SignalOut(k + Nfft + l);
           FirstWindow(k) = FirstWindow(k) + SignalOut(k + l)^2;
           SecondWindow(k) = SecondWindow(k) + SignalOut(k + Nfft + l)^2;
       end
       FunctionOfCorrelation(k) =...
           MultiplicationOfWindows(k)/sqrt(FirstWindow(k) * SecondWindow(k));
   end
end