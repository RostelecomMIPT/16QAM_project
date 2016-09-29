function [ PositionOfTs ] = PositionOfTs( FunctionOfCorrelation,LevelOfIncreasing )
    [MaxAmp, MaxIndex] =...
        max(FunctionOfCorrelation((Nfft/8) : (2*Nfft/8+Nfft)));
    CutLevel = MaxAmp*(10^((LevelOfIncreasing/20)));
    l = 1; m = 1;
    while ((l ~= 0) || (m ~= 0))
        if ((l ~=0) && (FunctionOfCorrelation(MaxIndex + l) < CutLevel))
            RightCut = MaxIndex + l;
            l = 0;
        else
            l = l + 1;
        end
        if ((m ~=0) && (FunctionOfCorrelation(MaxIndex - m) < CutLevel))
            LeftCut = MaxIndex - m;
            m = 0;
        else
            m = m + 1;
        end
    end
    PositionOfTs = fix((LeftCut + RightCut)/2);
end

