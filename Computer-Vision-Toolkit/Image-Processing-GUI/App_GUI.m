function image_gui

    % Create the main window
    fig = figure('Name', 'Image GUI', ...
        'NumberTitle', 'off', ...
        'Position', [300 200 800 500], ...
        'Color', [0.95 0.95 0.95]);

    % Create area to show the image
    ax = axes('Parent', fig, ...
        'Units', 'pixels', ...
        'Position', [250 100 520 380], ...
        'Box', 'on');

    % Variables to store images
    img = [];           % current image
    original_img = [];  % original uploaded image

    % ==============================
    % Basic buttons (left side)
    

    % Upload image button
    uicontrol('Style', 'pushbutton', ...
        'String', 'Upload Image', ...
        'BackgroundColor', [0.3 0.8 0.3], ...
        'Position', [30 420 180 40], ...
        'Callback', @uploadImage);

    % Convert to gray button
    uicontrol('Style', 'pushbutton', ...
        'String', 'RGB to Gray', ...
        'BackgroundColor', [0.7 0.7 0.7], ...
        'Position', [30 370 180 40], ...
        'Callback', @grayImage);

    % Convert to binary button
    uicontrol('Style', 'pushbutton', ...
        'String', 'Convert to Binary', ...
        'BackgroundColor', [1 1 1], ...
        'Position', [30 320 180 40], ...
        'Callback', @binaryImage);

    % Reset image button
    uicontrol('Style', 'pushbutton', ...
        'String', 'Reset Image', ...
        'BackgroundColor', [0 1 1], ...
        'Position', [30 250 180 40], ...
        'Callback', @resetImage);

    % ==============================
    % Extra buttons (bottom row)
    

    % Show histogram button
    uicontrol('Style', 'pushbutton', ...
        'String', 'Show Histogram', ...
        'BackgroundColor', [0.8 0.6 1], ...
        'Position', [250 40 160 30], ...
        'Callback', @showHistogram);

    % Complement (invert) button
    uicontrol('Style', 'pushbutton', ...
        'String', 'Complement Image', ...
        'BackgroundColor', [0.8 0.6 1], ...
        'Position', [420 40 160 30], ...
        'Callback', @complementImage);

    % Edge detection button
    uicontrol('Style', 'pushbutton', ...
        'String', 'Edge Detection', ...
        'BackgroundColor', [0.8 0.6 1], ...
        'Position', [590 40 160 30], ...
        'Callback', @edgeDetection);

    % ==============================
    % Functions for each button
    

    % --- Upload image from computer ---
    function uploadImage(~, ~)
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp;*.tiff'}, 'Select image');
        if isequal(file, 0), return; end
        img = imread(fullfile(path, file));
        original_img = img;
        imshow(img, 'Parent', ax);
        axis(ax, 'image', 'off');
    end

    % --- Convert image to gray level ---
    function grayImage(~, ~)
        if isempty(img), return; end
        if size(img, 3) == 3
            img = rgb2gray(img); % change from RGB to grayscale
        end
        imshow(img, 'Parent', ax);
        axis(ax, 'image', 'off');
    end

    % --- Convert image to binary using Otsu method ---
    function binaryImage(~, ~)
        if isempty(img), return; end
        if size(img, 3) == 3
            gray_img = rgb2gray(img); % make sure image is gray
        else
            gray_img = img;
        end
        level = graythresh(gray_img);      % find automatic threshold (Otsu)
        img = imbinarize(gray_img, level); % convert to black and white
        imshow(img, 'Parent', ax);
        axis(ax, 'image', 'off');
    end

    % --- Show histogram of current image ---
    function showHistogram(~, ~)
        if isempty(img), return; end
        if size(img, 3) == 3
            gray_img = rgb2gray(img); % convert to gray for histogram
        else
            gray_img = img;
        end
        figure;
        imhist(gray_img);
        title('Histogram of Image');
    end

    % --- Invert (complement) image colors ---
    function complementImage(~, ~)
        if isempty(img), return; end
        img = imcomplement(img); % invert image colors
        imshow(img, 'Parent', ax);
        axis(ax, 'image', 'off');
    end

    % --- Detect edges using Canny method ---
    function edgeDetection(~, ~)
        if isempty(img), return; end
        if size(img, 3) == 3
            gray_img = rgb2gray(img);
        else
            gray_img = img;
        end
        img = edge(gray_img, 'Canny'); % use Canny edge detector
        imshow(img, 'Parent', ax);
        axis(ax, 'image', 'off');
    end

    % --- Reset image to the original one ---
    function resetImage(~, ~)
        if isempty(original_img), return; end
        img = original_img;
        imshow(img, 'Parent', ax);
        axis(ax, 'image', 'off');
    end
end
