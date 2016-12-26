% IMAGE CODER MAIN FUNCTION
% 
% Complete Dicrete Wavelet Transform of an input image, decomposition and
% coding using the SPIHT algorithm (Zerotree) and decoding, reconstructing
% the resulting bittream of the SPIHT codification. Finally, computation of
% the PSNR and MSE between the reconstructed (output) and the original
% (input) image.
% 
% READ contents.m
% 
%   J. de la Rica CCAV-UPC Dec-2016
fprintf('----------------          Welcome to Wavelet Coding Algorithm !         ----------------\n');
fprintf('----------------     Code implemented by: J. de la Rica                 ----------------\n');
% READING ORIGINAL IMAGE
fprintf('Images available: camman.lum     diff.lum     fruit.lum     pam256.lum     people.lum\n');
infilename = input('Input the name of the original image: ');
fprintf('----------------                   Reading input image                  ----------------\n');
% infilename = 'camman.lum';
outfilename = 'out.jpg';
[img] = Read_Image(infilename);
fprintf('----------------             Getting image general information          ----------------\n');
fprintf('                                         done! :-)\n');
Display_Image(img); title 'Input Image';
in_hist = imhist(img);

% ORIGINAL IMAGE GENERAL INFO
[nRow, nColumn] = size(img);
OrigSize = size(img, 1);
rate = 1;
max_bits = floor(rate * OrigSize^2);
img_fin = zeros(size(img));
im_double = im2double(img);

% DISCRETE WAVELET TRANSFORM - ANALYSIS

fprintf('----------------         Discrete Wavelet Transform Decomnposition      ----------------\n');

level = 3;
n = size(img,1);
n_log = log2(n); 

[LP_DecFilter,HP_DecFilter,LP_RecFilter,HP_RecFilter] = wfilters('bior4.4');
[I_Wavedata , S] = DWT_Analysis(img, level, LP_DecFilter, HP_DecFilter);
fprintf('                                         done! :-)\n');
figure;
Display_Image(I_Wavedata); title 'DWT Decomposition';

% SUB-BLOCK SPLIT + VARIANCE COMPUTATION
[LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1] = SubBlocks_Split(I_Wavedata);

V_LL3 = Compute_Variance(LL3);
V_HL3 = Compute_Variance(HL3);
V_LH3 = Compute_Variance(LH3);
V_HH3 = Compute_Variance(HH3);

V_HL2 = Compute_Variance(HL2);
V_LH2 = Compute_Variance(LH2);
V_HH2 = Compute_Variance(HH3);

V_HL1 = Compute_Variance(HL1);
V_LH1 = Compute_Variance(LH1);
V_HH1 = Compute_Variance(HH1);

% BINARIZATION
[LL3_b] = SubBlock_Binarization(V_LL3,LL3);
[HL3_b] = SubBlock_Binarization(V_HL3,HL3);
[LH3_b] = SubBlock_Binarization(V_LH3,LH3);
[HH3_b] = SubBlock_Binarization(V_HH3,HH3);

[HL2_b] = SubBlock_Binarization(V_HL2,HL2);
[LH2_b] = SubBlock_Binarization(V_LH2,LH2);
[HH2_b] = SubBlock_Binarization(V_HH2,HH2);

[HL1_b] = SubBlock_Binarization(V_HL1,HL1);
[LH1_b] = SubBlock_Binarization(V_LH1,LH1);
[HH1_b] = SubBlock_Binarization(V_HH1,HH1);

% CLASSIFICATION 
[LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1] = Classification(LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1);

% DWT WAVEDATA RECONSTRUCTION 
[DWT_Wavedata] = rec(LL3, HL3, LH3, HH3, HL2, LH2, HH2, HL1, LH1, HH1);

% SPIHT ALGORITHM - CODER

fprintf('----------------               SPIHT Algorithm ENCODING                 ----------------\n');
fprintf('----------------                           .                            ----------------\n');
fprintf('----------------                           .                            ----------------\n');
fprintf('----------------                           .                            ----------------\n');
block_size = nRow*nColumn;
[spiht_bitstream] = SPIHT_Coder(DWT_Wavedata, max_bits, block_size, level);
fprintf('                                         done! :-)\n');

% SPIHT ALGORITHM - DECODER
fprintf('----------------               SPIHT Algorithm DECODING [...]           ----------------\n');
fprintf('----------------                           .                            ----------------\n');
fprintf('----------------                           .                            ----------------\n');
fprintf('----------------                           .                            ----------------\n');
[img_nspiht] = SPIHT_Decoder(spiht_bitstream);
fprintf('                                         done! :-)\n');

% Discrete Wavelet Transform - Synthesis
fprintf('----------------          Discrete Wavelet Transform Reconstruction       ----------------\n');
[img_rec] = DWT_Synthesis(img_nspiht, S, LP_RecFilter, HP_RecFilter, level);
fprintf('                                         done! :-)\n');
figure;
out = im2double(img_rec);
out_uint = uint8(out);
Display_Image(img_rec); title 'Output Image';

out_hist = imhist(out_uint);

imwrite(out, gray(256), outfilename, 'jpg');

% MSE COMPUTATION

fprintf('----------------                         Computing MSE                    ----------------\n');
Q = 255;
in = im2double(img);
out = im2double(img_rec);
I = imsubtract(out,in);
MSE = sum(sum((I).^2))/(nRow / nColumn);
fprintf('                                         done! :-)\n');
fprintf('----------------                         Computing PSNR                    ----------------\n');
fprintf('                                         done! :-)\n');
PSNR = 10*log10(Q*Q/MSE);
fprintf('The psnr performance is %.2f dB\n', abs(PSNR));
