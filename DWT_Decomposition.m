function [c,s] = DWT_Decomposition(x,n,varargin)
%  
% Discrete Wavelet Transform Analysis Decomposition
% 
% input:    x : Original input image
%           n : DWT level
% varargin: Lo_D : low-pass decomposition filter
%           Hi_D : high-pass decomposition filter
%
% output:   C : wavelet decomposition vector
%           S : bookeeping matrix
%
%   J. de la Rica, CCAV-UPC Dec-2016

if errargn(mfilename,nargin,[3:4],nargout,[0:2]), error('*'), end
if errargt(mfilename,n,'int'), error('*'), end
if nargin==3
    [Lo_D,Hi_D] = wfilters(varargin{1},'d');
else
    Lo_D = varargin{1};   Hi_D = varargin{2};
end

% Initialization.
s = [size(x)];
c = [];

for i=1:n
    [x,h,v,d] = dwt2(x,Lo_D,Hi_D,'mode','per'); % decomposition
    c = [h(:)' v(:)' d(:)' c];     % store details
    s = [size(x);s];               % store size

end

% Last approximation.
c = [x(:)' c];
s = [size(x);s];