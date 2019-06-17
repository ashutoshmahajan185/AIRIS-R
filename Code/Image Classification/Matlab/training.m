
clc;
%Internet Source url, no significance here
url = 'D:\BE Project\Semester 8\Image Classification\Test dataset';


% Output folder
outputFolder = fullfile('D:\BE Project\Semester 8\Image Classification\Test dataset');

if ~exist(outputFolder, 'dir') % download only once
    disp('Downloading 126MB Caltech101 data set...');
    untar(url, outputFolder);
end

%Source folder where the dataset is stored
rootFolder = fullfile(outputFolder);

%Creating Sets of categories to be checked.
imgSets = [ imageSet(fullfile(rootFolder, 'animals')), ...
            imageSet(fullfile(rootFolder, 'bikes')), ...
            imageSet(fullfile(rootFolder, 'laptop')) ];


{ imgSets.Description } % display all labels on one line
[imgSets.Count]         % show the corresponding count of images


% determine the smallest amount of images in a category
minSetCount = min([imgSets.Count]); 

% Use partition method to trim the set.
imgSets = partition(imgSets, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
[imgSets.Count]


[trainingSets, validationSets] = partition(imgSets, 0.3, 'randomize');

%Read the images from the training set.
airplanes = read(trainingSets(1),1);
ferry     = read(trainingSets(2),1);
laptop    = read(trainingSets(3),1);

figure
%Plotting the result of Images extracted from specified categories
subplot(1,3,1);
imshow(airplanes)
subplot(1,3,2);
imshow(ferry)
subplot(1,3,3);
imshow(laptop)

%Defining the bag of features after traning of data
bag = bagOfFeatures(trainingSets);


img = read(imgSets(1), 1);
featureVector = encode(bag, img);

% Plot the histogram of visual word occurrences
figure
bar(featureVector)
title('Visual word occurrences')
xlabel('Visual word index')
ylabel('Frequency of occurrence')

%Classify image into category
categoryClassifier = trainImageCategoryClassifier(trainingSets, bag);
%Check the efficiency of classification
confMatrix = evaluate(categoryClassifier, trainingSets);
%Check the efficiency of Validation
confMatrix = evaluate(categoryClassifier, validationSets);
% Compute average accuracy
mean(diag(confMatrix));
