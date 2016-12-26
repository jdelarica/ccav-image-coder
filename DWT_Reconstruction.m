function [x] = DWT_Reconstruction(c,s,varargin)
%
%   LP_RecFilter : Low-pass reconstruction filter
%   HP_RecFilter : High-pass reconstruction filter.
%
% 
% J. de la Rica CCAV-UPC Dec-2016
if errargn(mfilename,nargin,[3:4],nargout,[0:1]), error('*'), end

x = DWT_AppCoef(c,s,varargin{:},0);
