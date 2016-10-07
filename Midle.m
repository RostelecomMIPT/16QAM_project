function [ c ] = Midle(FunctionOfCorrelation)
    Level=3;%уровень спуска в ƒб
    N=200;
    Sdwig=FunctionOfCorrelation(N:1152+N);
    [MaxLevel, MaxNumber] = max(Sdwig);
    a=[MaxLevel MaxNumber];
    CutLevel=1/(10^(Level/20)/MaxLevel);
    for i=1:N
        if FunctionOfCorrelation(MaxNumber+N+i)<CutLevel
            RightCut=MaxNumber+i+N;
            break;
        end;
    end
    for i=1:N
        if FunctionOfCorrelation(MaxNumber+N-i)<CutLevel
            LeftCut=MaxNumber+N-i;
            break;
        end;
    end
    c=fix((LeftCut+RightCut)/2)  ;
end
