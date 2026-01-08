% Project #3 


clc; clear; close all;

%% 1) Read the image
imageName = 'coins.png'; % image name
if ~exist(imageName, 'file')
    error('Image file not found.');
end

img = imread(imageName);

% Convert to grayscale if the image is RGB
if size(img,3) == 3
    grayImage = rgb2gray(img);
else
    grayImage = img;
end

figure, imshow(grayImage);
title('Original grayscale image');

%% 2) Improve the image (reduce noise + adjust contrast)
grayImage = medfilt2(grayImage,[3 3]);   % remove small noise
grayImage = imadjust(grayImage);         % enhance contrast

%% 3) Convert to binary (black and white)
threshold = graythresh(grayImage);
binaryImage = imbinarize(grayImage, threshold * 0.85); % slightly lower threshold

% Invert if the coins appear black instead of white
if mean(grayImage(binaryImage)) < mean(grayImage(~binaryImage))
    binaryImage = ~binaryImage;
end

%% 4) Clean up the binary image
binaryImage = imfill(binaryImage,'holes');   % fill holes inside coins
binaryImage = imclearborder(binaryImage);    % remove objects touching borders
binaryImage = bwareaopen(binaryImage,80);    % remove tiny noise

figure, imshow(binaryImage);
title('Cleaned binary image');

%% 5) Count coins and get their features
[labeledCoins, coinCount] = bwlabel(binaryImage,8);
coinStats = regionprops(labeledCoins,'EquivDiameter','Centroid');

diameters = [coinStats.EquivDiameter];
centers = cat(1, coinStats.Centroid);

if isempty(diameters)
    disp('No coins detected.');
    return;
end

%% 6) Classify coins based on diameter
avgDiameter = mean(diameters);       % average diameter
isBig = diameters > avgDiameter;     % check which are large

bigCount = sum(isBig);
smallCount = sum(~isBig);

%% 7) Print results
fprintf('\n-- Coins Detection Result --\n');
fprintf('Total coins: %d\n', coinCount);
fprintf('Large coins: %d\n', bigCount);
fprintf('Small coins: %d\n', smallCount);

%% 8) Show results on the image
figure, imshow(img);
title('Coins Classification');
hold on;
for i = 1:coinCount
    if isBig(i)
        txt = 'Large';
        color = 'r';
    else
        txt = 'Small';
        color = 'b';
    end
    text(centers(i,1), centers(i,2), txt, 'Color', color, ...
        'FontSize', 12, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
end
hold off;
