function [ FunctionOfCorrelation ] = FuncCorrelation( SignalOut, Nfft )
ab=zeros(1,length(SignalOut)-1024);
b=zeros(1,length(SignalOut)-1024);
a=zeros(1,length(SignalOut)-1024);
c=zeros(1,length(SignalOut)-1024);
SignalOut1=[SignalOut zeros(1,100000)]; 
   for k=0:length(SignalOut)-1025
       for l=1:Nfft/16
           ab(k+1)= ab(k+1)+SignalOut1(k+l)*SignalOut1(k+Nfft+l);
           a(k+1)=a(k+1)+SignalOut1(k+l)^2;
           b(k+1)=b(k+1)+SignalOut1(k+Nfft+l)^2;
       end
       c(k+1)=ab(k+1)/sqrt(a(k+1)*b(k+1));
   end
   FunctionOfCorrelation=c;
end