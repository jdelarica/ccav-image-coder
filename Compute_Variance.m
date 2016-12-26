function [V] = Compute_Variance(in)
% 
%  Computes the variance of a sub-block
% 
% input: in: Sub-block/matrix
% 
% output: V: Variance of the sub-block in
% 
% J. de la Rica CCAV-UPC Dec-2016
% 
% V = var(in(:));
V = var(reshape(in(:,:),[],1));
end