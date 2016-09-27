function [ FunctionOfCorrelation ] = FuncCorrelation( SignalOut, Nfft )
b=zeros(1,length(SignalOut)-1024);
SignalOut1=[SignalOut zeros(1,100000)]; 
   for k=0:127+length(SignalOut)-1152
       for l=1:Nfft/8
           b(k+1)= b(k+1)+SignalOut1(k+l)*SignalOut1(k+Nfft+l);
       end
   end
   FunctionOfCorrelation=b;
end