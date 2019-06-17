clc;
vid = videoinput('winvideo', 1, 'YUY2_640x480');
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 5;

img = getsnapshot(vid);
%img = imread('D:\BE Project\Semester 8\Image Classification\Input dataset\0001.jpg');
%img1 = imread('D:\BE Project\Semester 8\Image Classification\Input dataset\image_0001.jpg');
start(vid)
for i = 1:100
    
    if(i == 3 || i == 4 || i == 5)
        [labelIdx, scores] = predict(categoryClassifier, img1 );
        object = categoryClassifier.Labels(labelIdx)
    else
        [labelIdx, scores] = predict(categoryClassifier, img);
        object = categoryClassifier.Labels(labelIdx)
    end
    answer = 3;
    if(strcmp(object,'bikes'))
        answer = 2;
    else
        answer = 1;
    end

    %answer = 1;
   % fprintf(s,char(answer))
    
    stats = regionprops(img, 'BoundingBox', 'Centroid');
    
    % Display the image
    imshow(img)
    
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

stop(vid);
