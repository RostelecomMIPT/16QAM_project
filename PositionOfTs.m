function [ PositionOfTs ] = PositionOfTs( FunctionOfCorrelation,...
                                          LevelOfIncreasing, Nfft)
    [MaxAmp, MaxIndex] =...
        max(FunctionOfCorrelation);
    CutLevel = MaxAmp*(10^(-(LevelOfIncreasing/20)));
    l = 1; m = 1;
    while ((l ~= 0) || (m ~= 0))
        if ((l ~=0) && ((FunctionOfCorrelation(MaxIndex + l) < CutLevel)))
            RightCut = MaxIndex + l;
            l = 0;
        elseif (l ~=0)
            l = l + 1;
        end
        if ((m ~=0) && (FunctionOfCorrelation(MaxIndex - m) < CutLevel))
            LeftCut = MaxIndex - m;
            m = 0;
        elseif (m ~=0)
            m = m + 1;
        end
    end
    PositionOfTs = fix((LeftCut + RightCut)/2)+Nfft/8;
end

