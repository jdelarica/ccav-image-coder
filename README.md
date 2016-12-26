# A Wavelet Image Coding Algorithm based on Human Visual System Characteristics
## Javier de la Rica
## Polytechnic University of Catalonia, Barcelona

##ABSTRACT

In this paper, an image-coding algorithm based on the discrete wavelet transform and the human visual system characteristics is proposed. After applying the DWT to an input image and dividing the resulting sub-blocks, different perceptual weights based on the activity of each block are applied to each one of them. Finally, the SPIHT algorithm is computed to obtain a bit stream and decode it to obtain the output image.

Keywords— Wavelet Transform DWT; SPIHT; Texture Analysis; Human Visual System, Variance

##1. INTRODUCTION

Image compression is minimizing the size in bytes of a graphics file without degrading the quality of the image to an unacceptable level. The reduction file size allows more images to be stored in a given amount of disk or memory space. It also reduces the time required for images to be sent over the Internet or downloaded from Web pages.

Image files can be compressed in several different ways. For Internet use, the two most common compressed graphic image formats are the JPEG format and the GIF format. Other techniques for image compression include the use of fractals and wavelets. These methods have not gained widespread acceptance for use on the Internet as of this writing. However, both offer promise because they offer higher compression ratios than the JPEG or GIF methods for some types of images. That is why this paper is going to explain and try the Wavelets compression method using the SPIHT algorithm, applying some algorithms to use human visual system characteristics to reconstruct the image that best matches the original one to the human visual system.

Two fundamental components of compression are redundancy and irrelevancy reduction. Redundancy reduction aims at removing duplication from the signal source. Irrelevancy reduction omits parts of the signal that will not be noticed by the signal receiver.

To follow the system implemented the following blocks diagram is offered; firstly, the DWT is applied to the original input image, obtaining the decomposition in the wavelet domain. The classification follows the DWT, studying those sub-blocks that have more activity, so the system applies a higher weighting factor to those sub-blocks.
The SPIHT algorithm is the one that codes the image into a bit stream, which would be sent, and the receiver would decode using the SPIHT decoder, reconstructing the image with the inverse DWT to obtain the original image.

##2. DISCRETE WAVELET TRANSFORM ANALYSIS

A discrete wavelet transform (DWT) is any wavelet transform for which the wavelets are discretely sampled. One of its advantages is temporal resolution, as it captures both frequency and location information. It is a separable processing which uses the same amount of input than output samples, using an iterated filter bank with High-Pass, H1, and Low-Pass, H0, filters and a decimation factor of 2, as shown in the following image.

This is the first step of the implementation, as the input image, for example, the cameraman from the Figure 3, is transformed into the Wavelet domain, obtaining the image in Figure 4, using the biorthogonal 4.4 filters. The transform is made for a single level, although the results could be improved increasing the amount of levels, which will be tested later.

With the Discrete Wavelet Transform Analysis, four kind of sub-images are found; the diagonal, vertical, and horizontal detail images and the approximation image.

##3. HUMAN VISUAL SYSTEM

Once the Discrete Wavelet Transform Analysis is computed, the different sub-blocks obtained are split and studied depending on their own activity.

The first step is to compute the variance of each sub-block, and compare the absolute value of each coefficient in each sub-block with the variance of the same sub-block. If the absolute value of the coefficient is lower than the variance, it is set to 0, otherwise it is set to 1, obtaining then a binary image. 

Later on, the sub-blocks are weighted depending on their activity, and therefore, their importance in the human visual system, so those sub-blocks who have more coefficients set to 1 on the previous step, are weighted with a weighting value of 0.52, and those who have less with a weighting value of 0.48. 

##4. SPIHT ALGORITHM

The Set Partitioning in Hierarchical Trees algorithm transmits wavelet transformed image in bit plane order with the most significant bits first. Compression happens when only some of the bit planes are transmitted. SPIHT offers an alternative explanation of the principles of the Embedded Zerotree Wavelet operation, so that the reasons for its excellent performance can be better understood, providing a better performance than EZW.

The SPIHT technique is based on three concepts:

a.	Partial ordering of the transformed image elements by magnitude, with transmission of order by a subset partitioning algorithm that is duplicated at the decoder.

b.	Ordered bit plane transmission of refinement bits.

c.	Exploitation of the self-similarity of the image wavelet transform across different scales.

###4.1. SPIHT Coder

Since the order in which the subsets are tested for significance is important, in a practical implementation the significance information is stored in three ordered lists, called list of insignificant sets (LIST), list of insignificant pixels (LIP) and list of significant pixels (LSP). In all lists each entry is identified by a coordinate (i,j), which in the LIP and LSP represents individual pixels, while in the LIST represents either the set D(i,j) or L(i,j).

To differentiate between them, a LIS entry is of type A if it represents D(i,j), and of type B if it represents L(i,j). During the sorting pass, the pixels in the LIP –which were insignificant in the previous pass– are tested, and those that become significant are moved to the LSP.

LIP is used to analyze the wavelet coefficients respectively to decide the significance of tree root node. LIS checks the coefficient sets which are composed of four wavelet coefficients to estimate the significance of whole coefficient set.

The SPIHT coder consists in the following four sequential and iterative steps.

1) Initialization: The LSP is set as an empty list, and the coordinates (i,j) are added to the LIP, and only those with descendants are also added to the LIS, as type A entries.

2) Sorting Pass: During the sorting pass, four binary bits are applied in encoding if four root nodes in LIPare insignificant. However, only one binary bit is needed to show its unimportance if these nodes are organized as one coefficient set in LIS. Therefore, a small coefficient in LIP leads to a number of binary bits transfer in order to represent its unimportance relative to multi thresholds.

3) Refinement Pass: For each entry (i,j) in the LSP, except those included in the last sorting pass, output the nth most significant bit.

4) Quantization-Step Update: Decrements n by 1 and goes back to step 2 (Sorting Pass).

A hierarchical quad-tree data structure for the wavelet transformed coefficients is formed. The tree is defined in such a way that each node has either no leaves or four offspring, which are from 2x2 adjacent pixels.

At the end of the decoder, the system obtains a bitstream in which the first value is the input image size, and the rest is the coded image in binary values. This bitstream is the one that would be transferred and received in the decoder, as follows.

###4.2. SPIHT Decoder

The SPIHT decoder emulates de coder, as it maintains exactly the same data structure as the coder, using symmetric sorting and refinement steps.

To examine the zero-tree the coder receives a bit telling whether the tree is significant or not. If the tree is significant it proceeds to the decomposition, while if the tree is not significant deduces a number of zeros in the current bit plane.

At the end of the decoder, an image in the Wavelet domain is obtained, ready to be reconstructed using the Discrete Wavelet Transform Synthesis to obtain the original image.

##5. DISCRETE WAVELET TRANSFORM SYNTHESIS

The Discrete Wavelet Transform Synthesis reconstructs the received image from the SPIHT Decoder in the wavelet domain, with the same High-Pass and Low-Pass filters than in the Analysis, this time with an interpolation factor of 2.

The levels used in the synthesis must be exactly the same as in the analysis, as it is a symmetric system with the same amount of filters and interpolation steps.
	
##6. RESULTS

To evaluate the performance of the proposed image-encoding algorithm, experiments are conducted to different international standard images, as the Cameraman and Lena, all of 256x256.

For the first image, zerotree method will demonstrate a great performance, although it may depend on the bitrate and DWT levels applied to the algorithm. For instance, using the Cameraman image, with three DWT levels and a bitrate of 0.1 in the SPIHT algorithm, the results in Figure 8 were obtained.

To evaluate the output image obtained, a MOS scale has been used, as it obtains the human user’s view of the quality of the system. It is obtained by averaging the results of a set of standard, subjective tests where a number of viewers rate the image quality from 1 (worst) to 5 (best) of both input and output images.

Asking 95 people the valuation of both input and output images the following values are the results obtained, obtaining a very different MOS value for each image.

Furthermore, the following table shows the representation of the PSNR for the system with and without taking into account the HVS characteristics depending on the bitrate applied into the SPIHT coder. It shows a considerable increase of the PSNR the higher the bitrate is, although the PSNR does not differ much between the algorithms with the HVS characteristics than the one that does not consider it.

Finally, a simple Matlab interface has been programmed in order to observe the different results using different images as the Lena, Fruit or People images.

##7. CONCLUSIONS

This paper established an image-coding algorithm, in which the sensitivity of human vision system is considered. Different perceptual weights are applied into different DWT sub-blocks of the input image. 

The algorithm that operates through set partitioning in hierarchical trees (SPIHT) accomplishes completely embedded coding. This algorithm uses the principles of partial ordering by magnitude, set partitioning by significance of magnitudes with respect to a sequence of decreasing thresholds, ordered bit plane transmission and self-similarity across scale in an image wavelet transform. 

The SPIHT algorithm obtains a great result with the DWT itself, without the use of HVS characteristics. The increment of the PSNR with the HVS is slightly significant, although the images are quite different.

The results are surprisingly great, obtaining an intelligible output image with enough PSNR even using a low bitrate, although as said before, the PSNR with HVS is slightly better than without the HVS.

The system could be improved using better activity/texture decisions, as the weighting values were chosen by trial and error. Furthermore, the DWT could be computed with different wavelet filters as Haar filters, although the biorthogonal filters have been used because of the great results obtained.

In the annex, the code of the whole project can be observed, with some explanations of each function in order to better understand each block.

##8. REFERENCES

[1] Li-Xiong Liu, Wei-Wei Wang, “A Wavelet Image Coding Algorithm based on Human Visual System Characteristics”, International Conference on Wavelet Analysis and Pattern Recognition, Hong-Kong, 30-3 Aug. 2008.

[2] Amir Said, William A. Pearlman, “A new and efficient image codec based on set partitioning in hierarchical trees”, IEEE Transaction on Circuits and Systems for Video Technology, vol.6, pp. 243-250, June 1996.

[3] Yo-Sung Ho, “Zerotree Wavelet Image Coding Based on the Human Visual System Model”, China, 1998.

[4] “Introduction to the Discrete Wavelet Transform”, Image and Video Processing, ETSETB-UPC.
