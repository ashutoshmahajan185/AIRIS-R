clc;
close all;
clear;
vid = videoinput('winvideo', 1, 'YUY2_640x480');
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 5;
filepath = 'E:\BE Project\Captures';
mkdir(filepath); 

for i = 1:20
    img = getsnapshot(vid);
    imshow(img)
    mov(i).cdata = img;
    mov(i).colormap = [];
    %mov(i).cdata=blobAnalysis(mov(i).cdata);
    img=mov(i).cdata;   
    stats = regionprops(img, 'BoundingBox', 'Centroid');
    filename = strcat('frame', num2str(i),'.jpg');
    disp(filename)       
    imwrite(img, strcat(filepath,filename),'jpg');
    
    imshow(img)
    
%     hold on
    
    %This is a loop to bound the red objects in a rectangular box.
%     for object = 1:length(stats)
%         bb = stats(object).BoundingBox;
%         bc = stats(object).Centroid;
%         rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
%         plot(bc(1),bc(2), '-m+')
%         a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
%         set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
%     end     
%     hold off
end
stop(vid);

%Read Background Image
Background=imread(strcat(filepath,'frame1.jpg'));

%Read Current Frame
CurrentFrame=imread(strcat(filepath,'frame10.jpg'));
%Display Background and Foreground

subplot(2,2,1);imshow(Background);title('BackGround Frame');
subplot(2,2,2);imshow(CurrentFrame);title('Current Frame');

%Convert RGB 2 HSV Color conversion
[Background_hsv]=round(rgb2hsv(Background));
[CurrentFrame_hsv]=round(rgb2hsv(CurrentFrame));
Out = bitxor(Background_hsv,CurrentFrame_hsv);

%Convert RGB 2 GRAY
Out=rgb2gray(Out);

%Read Rows and Columns of the Image
[rows columns]=size(Out);
%Convert to Binary Image
for i=1:rows
    for j=1:columns

        if Out(i,j) >0
            BinaryImage(i,j)=1;
        else
            BinaryImage(i,j)=0;
        end
    end
end

%Apply Median filter to remove Noise
FilteredImage=medfilt2(BinaryImage,[5 5]);

%Boundary Label the Filtered Image
[L num]=bwlabel(FilteredImage);

STATS=regionprops(L,'all');
cc=[];
removed=0;

%Remove the noisy regions 
for i=1:num
    dd=STATS(i).Area;
    if (dd < 500)
        L(L==i)=0;
        removed = removed + 1;
        num=num-1;
    end
end

[L2 num2]=bwlabel(L);

% Trace region boundaries in a binary image.
[B,L,N,A] = bwboundaries(L2);

%Display results

%subplot(2,2,3),  imshow(bwlabel(Background));title('BackGround Detected');
subplot(2,2,4),  imshow(L2);title('Blob Detected');

hold on;

for k=1:length(B),
    if(~sum(A(k,:)))
        boundary = B{k};
        plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
        for l=find(A(:,k))'
            boundary = B{l};
            plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
        end
    end
end