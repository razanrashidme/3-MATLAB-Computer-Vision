
% Task 2: Intensity Thresholding

clc;        % clear the command window
clear;      % remove all variables
close all;  % close all figures

% read the image 
img = imread('Lenna.png');

% if the image is colored, make it gray
if size(img,3) == 3
    img = rgb2gray(img);
end

% make a copy of the image
output_img = img;

% pixels less than 50 -> black
output_img(img < 50) = 0;

% pixels more than 150 -> white
output_img(img > 150) = 255;

% between 50 and 150 stay the same (no change)

% show both images
subplot(1,2,1);
imshow(img);
title('Original Image');

subplot(1,2,2);
imshow(output_img);
title('After Thresholding');
