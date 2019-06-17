%% Erode Binary Image with Line Structuring Element
% 
%%
% Read binary image into the workspace.
image = imread('original.jpg');
originalBW = rgb2gray(image);
%%
% Create a flat, line-shaped structuring element.
se = strel('line',10,0);
%%
% Erode the image with the structuring element.
erodedBW = imerode(originalBW,se);
%%
% View the original image and the eroded image.  
figure
imshow(image)
figure
imshow(originalBW)
figure
imshow(erodedBW) 
