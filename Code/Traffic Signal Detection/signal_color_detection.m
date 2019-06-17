
%Initialise video capturing object. This video is captured from the web
%camera of the processing device using the MATLAB OS Generic hardware adapter library
%that provides the hardware-software interfacing between the camera and the
%processing software (MATLAB)
vid = videoinput('winvideo', 1, 'YUY2_640x480');
%vid = VideoReader('test.mp4');
%used for direct video input

%Declaring the serial comunication object , to initialise serial
%comunication
fopen('COM8'); %opens the com port for arduino information relay
s = serial('COM7','BAUD',9600); %properties of the port, BAUD signifies the bit rate
%open serial port
fopen(s);

% Set the properties of the video object
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 5;
%This code snippet splits the video into frames and then operation on
%individual frames is done

%start the video aquisition here
start(vid)
%Set a loop that stop after 100 frames of aquisition. The greater the
%number the longer the video frame acquisition. In the final version of
%code a while loop will be used.
for i=1:100

    % Get the snapshot of the current frame
    IMRED = getsnapshot(vid);
    % Now to track red objects in real time we have to subtractED the red component 
    % from the grayscale image to extract the red components in the image.
    diff_im = imsubtract(IMRED(:,:,1), rgb2gray(IMRED));
    gr = graythresh(diff_im);
    %Median filter IS USED to filter out noise
    diff_im = medfilt2(diff_im, [3 3]);
    % Convert the resulting grayscale image into a binary image.
    diff_im = im2bw(diff_im,.18);
    
    % Remove all those pixels less than 300px
    diff_im = bwareaopen(diff_im,300);
    
      
    %Label all the connected components in the image
    %and also count the nuber of red objects in frame
    [bw bw1] = bwlabel(diff_im, 8);
    %condition if one or more than one red signal is present in frame,then
    %send value '100' else send 101
    if bw1 >= 1
        fprintf(s,100);
    elseif bw1 == 0
       fprintf(s,101);
  
    %   
    stats = regionprops(bw, 'BoundingBox', 'Centroid');
    
    % Display the image
    imshow( IMRED )
    
    hold on
    
    %This is a loop to bound the red objects in a rectangular box.
    for object = 1:length(stats)
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2), '-m+')
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
    end
    
    hold off
    end
end
% Both the loops end here.
% Stop the video aquisition.
stop(vid);
flushdata(vid);
fclose(s);
clear all