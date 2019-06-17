clc;
img = imread('D:\BE Project\Semester 8\Image Classification\Input dataset\0001.jpg');
img1 = imread('D:\BE Project\Semester 8\Image Classification\Input dataset\image_0001.jpg');

for i = 1:10
    
    if(i == 3 || i == 4 || i == 5)
        [labelIdx, scores] = predict(categoryClassifier, img1 );
        object = categoryClassifier.Labels(labelIdx)
    else
        [labelIdx, scores] = predict(categoryClassifier, img);
        object = categoryClassifier.Labels(labelIdx)
    end
    answer = 3;
    if(strcmp(object,'bikes'))
        answer = 1;
    else
        answer = 2;
    end

    %answer = 1;
    fprintf(s,char(answer))
end

