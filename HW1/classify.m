train_data = zeros(50000, 3072);
train_labels = zeros(50000, 1);
load('data_batch_1.mat');
train_data_1 = im2double(data);
train_labels_1 = labels;
train_labels(1:10000, 1) = train_labels_1;
train_data(1:10000, :) = train_data_1;
load('data_batch_2.mat');
train_data_2 = im2double(data);
train_labels_2 = labels;
train_labels(10001:20000, 1) = train_labels_2;
train_data(10001:20000, :) = train_data_2;
load('data_batch_3.mat');
train_data_3 = im2double(data);
train_labels_3 = labels;
train_labels(20001:30000, 1) = train_labels_3;
train_data(20001:30000, :) = train_data_3;
load('data_batch_4.mat');
train_data_4 = im2double(data);
train_labels_4 = labels;
train_labels(30001:40000, 1) = train_labels_4;
train_data(30001:40000, :) = train_data_4;
load('data_batch_5.mat');
train_data_5 = im2double(data);
train_labels_5 = labels;
train_labels(40001:50000, 1) = train_labels_5;
train_data(40001:50000, :) = train_data_5;
load('test_batch.mat');
test_data = im2double(data);
test_labels = labels;

%To make sure that you understand the data format, write code to display 
%the first airplane in the test set. [5 pt]


image = zeros(32, 32, 3);
for row = 1 : 32
    image(row, :, 1) = train_data(19, 1 + (row - 1) * 32 : row * 32);
    image(row, :, 2) = train_data(19, 1025 + (row - 1) * 32 : 1024 + row * 32);
    image(row, :, 3) = train_data(19, 2049 + (row - 1) * 32 : 2048 + row * 32);
end
imshow(image);

%Construct a nearest-neighbor (NN) classifier that predicts a label for a 
%test image by returning the label of the closest training image, using the 
%Euclidean distance between vector of pixel values. You can use the MATLAB 
%function pdist2 to efficiently compute the pairwise distances between the 
%test examples and all training examples. [10 pt]
%{

%Select a test image
num_test_samples = 100;
num_training_samples = 5000;
predicted_labels = zeros(100, 1);
for y = 1: 100
    %Extract a test image
    test_image = test_data(y, :);
    distance_array = zeros(1, num_training_samples);
    %Evaluate euclidean distance from test image to 10,000 training images
    for x = 1 : num_training_samples
        dist = pdist2(train_data(x, :), test_image);
        distance_array(1, x) = dist;
    end
    min_value = min(distance_array);
    closest_image_index = find(distance_array == min_value);
    predicted_labels(y, 1) = train_labels(closest_image_index, 1);
end


%Compute a class confusion matrix, which is a 10x10 matrix where entry (i,j)
%is the fraction of times an image of class 'i' was predicted to be class 
%'j'. Display this matrix as an image using imagesc with a colorbar and 
%appropriate colormap. Also, report back the average classification rate 
%across all classes, which is the average of the diagonal values in this matrix. [10 pt]



subset_test_labels = test_labels(1:num_test_samples, 1);
confusion_matrix = zeros(10);
for x = 0:9
   class_indices = find(subset_test_labels == x);
   for i = 1 : numel(class_indices)
       predicted_label = predicted_labels(class_indices(i, 1), 1);
       confusion_matrix(x+1, predicted_label+1) = confusion_matrix(x+1, predicted_label+1) + (1/numel(class_indices));
   end
end

sum = 0;
for x = 1:10
    sum = sum + confusion_matrix(x, x);
end
average_classification_rate = sum / 10;
disp(average_classification_rate);

imagesc(confusion_matrix);
colorbar;
%}

%Construct a K NN-classifier that computes the K closest training images, 
%and returns the most common label from this set. Experiment with K = 1,3,5.
%What is the best-performing K? Display its class-confusion matrix and report 
%the average missclassificaiton rate. [15pt]
%{

K = 5;
num_test_samples = 100;
num_training_samples = 5000;
predicted_K_labels = zeros(K, 1);
predicted_labels = zeros(num_test_samples, 1);

distance_array = zeros(1, num_training_samples);

for y = 1: num_test_samples
    %Extract a test image
    test_image = test_data(y, :);
    %Evaluate euclidean distance from test image to 10,000 training images
    for x = 1 : num_training_samples
        dist = pdist2(train_data(x, :), test_image);
        distance_array(1, x) = dist;
    end
    %Find k closest neighbors
    for i = 1 : K
        min_value = min(distance_array);
        closest_image_index = find(distance_array == min_value);
        distance_array(closest_image_index) = inf;
        predicted_K_labels(i, 1) = train_labels(closest_image_index, 1);
    end
    predicted_labels(y, 1) = mode(predicted_K_labels);
end

subset_test_labels = test_labels(1:num_test_samples, 1);
confusion_matrix = zeros(10);
for x = 0:9
   class_indices = find(subset_test_labels == x);
   for i = 1 : numel(class_indices)
       predicted_label = predicted_labels(class_indices(i, 1), 1);
       confusion_matrix(x+1, predicted_label+1) = confusion_matrix(x+1, predicted_label+1) + (1/numel(class_indices));
   end
end

sum = 0;
for x = 1:10
    sum = sum + confusion_matrix(x, x);
end
average_classification_rate = sum / 10;
disp(average_classification_rate);

imagesc(confusion_matrix);
colorbar;

%}
%Construct a NN-classifier that uses normalized correlation (or cosine 
%similarity) instead of Euclidian distance. Report the best missclassification
%rate (find the K that has the best performance) and display its 
%class-confusion matrix. [15pt]

%{
K = 5;
num_test_samples = 100;
num_training_samples = 5000;
predicted_K_labels = zeros(K, 1);
predicted_labels = zeros(num_test_samples, 1);

distance_array = zeros(1, num_training_samples);

for y = 1: num_test_samples
    %Extract a test image
    test_image = test_data(y, :);
    %Evaluate euclidean distance from test image to num_training_samples images
    for x = 1 : num_training_samples
        dist = pdist2(train_data(x, :), test_image, 'cosine');
        distance_array(1, x) = dist;
    end
    %Find k closest neighbors
    for i = 1 : K
        min_value = min(distance_array);
        closest_image_index = find(distance_array == min_value);
        distance_array(closest_image_index) = inf;
        predicted_K_labels(i, 1) = train_labels(closest_image_index, 1);
    end
    predicted_labels(y, 1) = mode(predicted_K_labels);
end

subset_test_labels = test_labels(1:num_test_samples, 1);
confusion_matrix = zeros(10);
for x = 0:9
   class_indices = find(subset_test_labels == x);
   for i = 1 : numel(class_indices)
       predicted_label = predicted_labels(class_indices(i, 1), 1);
       confusion_matrix(x+1, predicted_label+1) = confusion_matrix(x+1, predicted_label+1) + (1/numel(class_indices));
   end
end

sum = 0;
for x = 1:10
    sum = sum + confusion_matrix(x, x);
end
average_classification_rate = sum / 10;
disp(average_classification_rate);

imagesc(confusion_matrix);
colorbar;

%}