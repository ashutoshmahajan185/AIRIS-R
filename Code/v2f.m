%v = VideoReader('v2f.mkv');
%for img = 1:v.NumberOfFrames;
%    filename = strcat('frame', num2str(img), '.jpg');
%    b = read(v, img);
%    imwrite(b, filename);
%end

 vid = VideoReader('v2f.mkv');
 numFrames = vid.NumberOfFrames;
 n=numFrames;
 for i = 1:5:n
 frames = read(vid,i);
 imwrite(frames,['Image' int2str(i), '.jpg']);
 im(i)=image(frames);
 end