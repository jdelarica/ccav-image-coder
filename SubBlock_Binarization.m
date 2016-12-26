function [in] = SubBlock_Binarization(V,in)
% Computation of the activity of each sub-block.
% 
%   V: Variance of the sub-block
%   in: current sub-block
% 
% J. de la Rica CCAV-UPC Dec-2016
for i = 1:length(in)
    for j = 1:length(in)
        if abs(in(i,j))>V
            in(i,j) = 1;
        else 
            in(i,j) = 0;
        end        
    end
end



end