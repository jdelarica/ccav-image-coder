function [DWT_Wavedata] = rec(LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1)
%       Reconstruction of the image in the DWT domain with each of the
%       sub-blocks weighted.
% 
% in:   LL3: 3rd level approximation image
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
% out: DWT_Wavedata: Image in wavelet domain.
% 
% J. de la Rica CCAV-UPC Dec-2016
% DWT_Wavedata = zeros(256,256);
DWT_Wavedata3 = [LL3 HL3 ; LH3 HH3];
DWT_Wavedata2 = [DWT_Wavedata3 HL2 ; LH2 HH2];
DWT_Wavedata = [DWT_Wavedata2 HL1 ; LH1 HH1];
end