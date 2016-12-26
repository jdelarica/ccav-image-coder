% Matlab implementation of a Wavelet Coding with SPIHT and Texture Analysis
%
% Functions listed as follow:
%
% MAIN -- Main function
% Read_Image -- Reading of a .lum image
% DWT_Analysis -- Wavelet decomposition
% SubBlocks_Split -- Division of the DWT sub-blocks
% Compute_Variance -- Computantion of each sub-block variance
% SubBlock_Binarization -- Assignment of 1 and 0 depending on the sub-block variance
% Classification -- Sub-blocks weighting
% Rec -- Reconstruction of the weighted sub-blocks in DWT domain
% SPIHT_Coder -- Encoder
% SPIHT_Decoder -- Decoder
% DWT_Synthesis -- Inverese wavelet decomposition
% 
% How To Use
% run MAIN.m
% 
% Input Values
% 'InputImage.lum'
% DWTLevels (=3 by default)
%
% ---------------------------
%   Performance evaluation:
%
%   Test image: camman.lum
%
%   bpp         PSNR w. HVS(dB)         PSNR w/o. HVS(dB)
%   0.1000          29.81                    29.32
%   0.2000          32.72                    32.25
%   0.3000          34.55                    34.03
%   0.4000          35.84                    35.48
%   0.5000          36.86                    36.59
%   0.6000          37.66                    37.37
%   0.7000          38.25                    38.04
%   0.8000          38.93                    38.70
%   0.9000          39.52                    39.34
%
% Ref.
%  
% CCAV Image Processing Project based on the paper "A Wavelet Coding Algorithm Based on Human Visual System Characteristics",
% Javier de la Rica, December 2016.
% ---------------------------
%
%