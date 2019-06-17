%% 
% Load the positive samples data from a .mat file. The file names and bounding boxes are contained in an array of structures named 'data'.
load('stopSigns.mat');   
%%
% Add the images location to the MATLAB path.
imDir = fullfile(matlabroot,'toolbox','vision','visiondata','stopSignImages');
addpath(imDir);
%%
% Specify the folder for negative images.
negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata','nonStopSigns');   
%%
% Train a cascade object detector called 'stopSignDetector.xml' using HOG features. The following command may take several minutes to run:
%trainCascadeObjectDetector('stopSignDetector.xml',data,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',5);   
%%
% Use the newly trained classifier to detect a stop sign in an image.
detector = vision.CascadeObjectDetector('stopSignDetector.xml');   
%%
% Read the image captured by the webcam
vid = videoinput('winvideo', 1, 'YUY2_640x480');
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 5;

img = getsnapshot(vid);
%img = imread('chair.jpg'); 
%%
% Detect a stop sign.
bbox = step(detector,img);

%%
% Send signal to Arduino to stop motors
% flag=1; % this is where we'll store the user's answer
% arduino=serial('COM13','BaudRate',9600); % create serial communication object on port COM4
%  
% fopen(arduino); % initiate arduino communication
%  
% while flag
%     fprintf(arduino,'%s',char(flag)); % send flag variable content to arduino
% end
%  
% fclose(arduino); % end communication with arduino
%%
% Insert bounding boxes and return marked image.
detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'stop sign');   
%%
% Display the detected stop sign.
figure;
imshow(detectedImg);
    
%%
% Remove the image directory from the path.
rmpath(imDir);