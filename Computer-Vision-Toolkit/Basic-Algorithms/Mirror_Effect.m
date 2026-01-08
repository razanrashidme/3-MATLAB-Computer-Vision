
% Task 1: Mirror Image

clc;        % clear the command window
clear;      % remove all variables
close all;  % close all figures


% read the image 
img = imread("Lenna.png");

% if the image is colored, make it gray
if size(img,3) == 3
  img = rgb2gray(img);
end

% make mirror image (flip left and right)
mirror_img = fliplr(img);

% show both images
subplot(1,2,1);
imshow(img);
title('Original Image');

subplot(1,2,2);
imshow(mirror_img);
title('Mirror Image');


