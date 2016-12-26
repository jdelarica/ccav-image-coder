function [I_Wavedata , S] = DWT_Analysis(img_in, level, LP_DecFilter, HP_DecFilter)
%
% Discrete Wavelet Transform Analysis
%
% input:    I : input image
%           level : wavelet decomposition level
%           LP_DecFilter : low-pass decomposition filter
%           HP_DecFilter : high-pass decomposition filter
%
% output:   I_Wavedata : decomposed image vector
%           S : corresponding bookkeeping matrix
% 
%   J. de la Rica CCAV-UPC Dec-2016

[C,S] = DWT_Decomposition(img_in,level,LP_DecFilter,HP_DecFilter); 

S(:,3) = S(:,1).*S(:,2);        % dim of detail coef nmatrices

L = length(S);

I_Wavedata = zeros(S(L,1),S(L,2));

% approximation image LL
I_Wavedata( 1:S(1,1) , 1:S(1,2) ) = reshape(C(1:S(1,3)),S(1,1:2));

for k = 2 : L-1
    rows = [sum(S(1:k-1,1))+1:sum(S(1:k,1))];
    columns = [sum(S(1:k-1,2))+1:sum(S(1:k,2))];
    % horizontal detail image HL
    c_start = S(1,3) + 3*sum(S(2:k-1,3)) + 1;
    c_stop = S(1,3) + 3*sum(S(2:k-1,3)) + S(k,3);
    I_Wavedata( 1:S(k,1) , columns ) = reshape( C(c_start:c_stop) , S(k,1:2) );
    % vertical detail image LH
    c_start = S(1,3) + 3*sum(S(2:k-1,3)) + S(k,3) + 1;
    c_stop = S(1,3) + 3*sum(S(2:k-1,3)) + 2*S(k,3);
    I_Wavedata( rows , 1:S(k,2) ) = reshape( C(c_start:c_stop) , S(k,1:2) );
    % diagonal detail image HH
    c_start = S(1,3) + 3*sum(S(2:k-1,3)) + 2*S(k,3) + 1;
    c_stop = S(1,3) + 3*sum(S(2:k,3));
    I_Wavedata( rows , columns ) = reshape( C(c_start:c_stop) , S(k,1:2) );

end

end