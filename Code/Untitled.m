%% Erode Binary Image with Line Structuring Element
% 
%%
% Read binary image into the workspace.
image = imread('original.jpg');
originalBW = rgb2gray(image);
%%
% Create a flat, line-shaped structuring element.
se = strel('line',18,50);
%%
% Erode the image with the structuring element.
erodedBW = imdilate(originalBW,se);
%%
% View the original image and the eroded image.  
figure
imshow(originalBW)
figure
imshow(erodedBW) 
