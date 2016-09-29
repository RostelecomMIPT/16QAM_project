function [ c ] = Midle(FunctionOfCorrelation)
    Level=3;%уровень спуска в ƒб
    N=200;
    [MaxLevel, MaxNumber] = max(FunctionOfCorrelation(N:1352));
    a=[MaxLevel MaxNumber];
    CutLevel=1/(10^(Level/20)/MaxLevel);
    l=1; m=1; Epsilon = 0.1;
    while (l~=0) && (m ~= 0)
        if ((FunctionOfCorrelation(MaxLevel + l) < CutLevel) && (l ~=0))
            RightCut = MaxNumber + l;
            l = 0;
        else
            l = l + 1;
        end
        if ((m ~=0) && (FunctionOfCorrelation(MaxNumber - m) < CutLevel))
            LeftCut = MaxNumber - m;
            m = 0;
        else
            m = m + 1;
        end
    end
    c=[RightCut LeftCut ];
end
