function [LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1] = SubBlocks_Split(I_Wavedata)
%
% Split of the DWT decomposition into sub-blocks.
% 
%       LL3: 3rd level approximation image
%       HL3: 3rd level horizontal detail image
%       LH3: 3rd level vertical detail image
%       HH3: 3rd level diagonal detail image
% 
%       HL2: 2nd level horizontal detail image
%       LH2: 2nd level vertical detail image
%       HH2: 2nd level diagonal detail image
% 
%       HL1: 1st level horizontal detail image
%       LH1: 1st level vertical detail image
%       HH1: 1st level diagonal detail image
% 
% J. de la Rica CCAV-UPC Dec-2016

% LL3 SUB-BLOCK
for i = 1:32
    for j = 1:32
        LL3(i,j) = I_Wavedata(i,j);
    end
end

% HL3 SUB-BLOCK
for i = 1:32
    for j = 33:64
        HL3(i,j-32) = I_Wavedata(i,j);
    end
end

% LH3 SUB-BLOCK
for i = 33:64
    for j = 1:32
        LH3(i-32,j) = I_Wavedata(i,j);
    end
end

% HH3 SUB-BLOCK
for i = 33:64
    for j = 33:64
        HH3(i-32,j-32) = I_Wavedata(i,j);
    end
end

% HL2 SUB-BLOCK
for i = 1:64
    for j = 65:128
        HL2(i,j-64) = I_Wavedata(i,j);
    end
end

% HH2 SUB-BLOCK
for i = 65:128
    for j = 65:128
        HH2(i-64,j-64) = I_Wavedata(i,j);
    end
end

% LH2 SUB-BLOCK
for i = 65:128
    for j = 1:64
        LH2(i-64,j) = I_Wavedata(i,j);
    end
end

% HL1 SUB-BLOCK
for i = 1:128
    for j = 129:256
        HL1(i,j-128) = I_Wavedata(i,j);
    end
end

% HH1 SUB-BLOCK
for i = 129:256
    for j = 129:256
        HH1(i-128,j-128) = I_Wavedata(i,j);
    end
end
% LH1 SUB-BLOCK
for i = 129:256
    for j = 1:128
        LH1(i-128,j) = I_Wavedata(i,j);
    end
end

end

