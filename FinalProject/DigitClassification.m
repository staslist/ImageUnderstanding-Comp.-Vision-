% Final Project
% CS 216
% Stanislav Listopad

% Below code + loadMNISTImages & loadMNISTLabels code was taken from
% Stanford's wiki website
% (http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset)

% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
train_images = (loadMNISTImages('MNIST/train-images.idx3-ubyte'));
train_labels = loadMNISTLabels('MNIST/train-labels.idx1-ubyte');

test_images = (loadMNISTImages('MNIST/t10k-images.idx3-ubyte'));
test_labels = loadMNISTLabels('MNIST/t10k-labels.idx1-ubyte');
 
% We are using display_network from the autoencoder code
images = reshape(train_images, [28, 28, 60000]);

% PART 1: Convert an image of five handwritten digits (ex: zip code) into a sequence of digits.
% Assume that all handwritten digits are written on the same line, of
% approximately the same size, and non-overlapping.

% Resize all training images to be template_w x template_h so as to allow HoG construction
% from images. For simplicty, template_w and template_h must be multiples
% of 16.

template_w = 96;
template_h = 96;

% FIX THE TEMPLATE_W & TEMPLATE_H ISSUES

train_size = 6000;
sub_train_labels = train_labels(1:train_size, 1);

resized_images = zeros(template_w, template_h, train_size);
for i = 1:train_size
    resized_images(:, :, i) = imresize(images(:, :, i), [template_w, template_h]);
end

train_images_hog = zeros(template_w / 8, template_h/8, 9, train_size);
for i = 1:train_size
    train_images_hog(:, :, :, i) = hog(resized_images(:, :, i));
end
% Create HoG template for digit 0-9

Digit0_Indeces = find(sub_train_labels == 0);
Digit1_Indeces = find(sub_train_labels == 1);
Digit2_Indeces = find(sub_train_labels == 2);
Digit3_Indeces = find(sub_train_labels == 3);
Digit4_Indeces = find(sub_train_labels == 4);
Digit5_Indeces = find(sub_train_labels == 5);
Digit6_Indeces = find(sub_train_labels == 6);
Digit7_Indeces = find(sub_train_labels == 7);
Digit8_Indeces = find(sub_train_labels == 8);
Digit9_Indeces = find(sub_train_labels == 9);

Digit0_Template = zeros(template_w/8, template_h/8, 9);
Digit1_Template = zeros(template_w/8, template_h/8, 9);
Digit2_Template = zeros(template_w/8, template_h/8, 9);
Digit3_Template = zeros(template_w/8, template_h/8, 9);
Digit4_Template = zeros(template_w/8, template_h/8, 9);
Digit5_Template = zeros(template_w/8, template_h/8, 9);
Digit6_Template = zeros(template_w/8, template_h/8, 9);
Digit7_Template = zeros(template_w/8, template_h/8, 9);
Digit8_Template = zeros(template_w/8, template_h/8, 9);
Digit9_Template = zeros(template_w/8, template_h/8, 9);

for i = 1:size(Digit0_Indeces, 1)
    Digit0_Template = Digit0_Template + train_images_hog(:, :, :, Digit0_Indeces(i, 1));
end
for i = 1:size(Digit1_Indeces, 1)
    Digit1_Template = Digit1_Template + train_images_hog(:, :, :, Digit1_Indeces(i, 1));
end
for i = 1:size(Digit2_Indeces, 1)
    Digit2_Template = Digit2_Template + train_images_hog(:, :, :, Digit2_Indeces(i, 1));
end
for i = 1:size(Digit3_Indeces, 1)
    Digit3_Template = Digit3_Template + train_images_hog(:, :, :, Digit3_Indeces(i, 1));
end
for i = 1:size(Digit4_Indeces, 1)
    Digit4_Template = Digit4_Template + train_images_hog(:, :, :, Digit4_Indeces(i, 1));
end
for i = 1:size(Digit5_Indeces, 1)
    Digit5_Template = Digit5_Template + train_images_hog(:, :, :, Digit5_Indeces(i, 1));
end
for i = 1:size(Digit6_Indeces, 1)
    Digit6_Template = Digit6_Template + train_images_hog(:, :, :, Digit6_Indeces(i, 1));
end
for i = 1:size(Digit7_Indeces, 1)
    Digit7_Template = Digit7_Template + train_images_hog(:, :, :, Digit7_Indeces(i, 1));
end
for i = 1:size(Digit8_Indeces, 1)
    Digit8_Template = Digit8_Template + train_images_hog(:, :, :, Digit8_Indeces(i, 1));
end
for i = 1:size(Digit9_Indeces, 1)
    Digit9_Template = Digit9_Template + train_images_hog(:, :, :, Digit9_Indeces(i, 1));
end

Digit0_Template = Digit0_Template / size(Digit0_Indeces, 1);
Digit1_Template = Digit1_Template / size(Digit1_Indeces, 1);
Digit2_Template = Digit2_Template / size(Digit2_Indeces, 1);
Digit3_Template = Digit3_Template / size(Digit3_Indeces, 1);
Digit4_Template = Digit4_Template / size(Digit4_Indeces, 1);
Digit5_Template = Digit5_Template / size(Digit5_Indeces, 1);
Digit6_Template = Digit6_Template / size(Digit6_Indeces, 1);
Digit7_Template = Digit7_Template / size(Digit7_Indeces, 1);
Digit8_Template = Digit8_Template / size(Digit8_Indeces, 1);
Digit9_Template = Digit9_Template / size(Digit9_Indeces, 1);

% load a training image from which to create N negative examples

Inegtrain = im2double(rgb2gray(imread('myfile.jpg')));

f = hog(Inegtrain);

template_neg = zeros(template_h / 8, template_w / 8, 9);

% Calculate how many times the template fits (without overlapping) into the
% negative training image.

rows = size(Inegtrain, 1) / template_h - 1;
columns = size(Inegtrain, 2) / template_w - 1;

for i = 1:rows
    for j = 1:columns
        template_neg = template_neg + f((template_h / 16) + (i-1)*(template_h/8)+(-((template_h / 16) - 1):(template_h / 16)),(template_w / 16) + (j-1)*(template_w/8)+(-((template_w / 16) - 1):(template_w / 16)),:); 
    end
end

template_neg = template_neg / (rows*columns);

Non_Digit_Template = template_neg;

Digit0_Template = Digit0_Template - template_neg;
Digit1_Template = Digit1_Template - template_neg;
Digit2_Template = Digit2_Template - template_neg;
Digit3_Template = Digit3_Template - template_neg;
Digit4_Template = Digit4_Template - template_neg;
Digit5_Template = Digit5_Template - template_neg;
Digit6_Template = Digit6_Template - template_neg;
Digit7_Template = Digit7_Template - template_neg;
Digit8_Template = Digit8_Template - template_neg;
Digit9_Template = Digit9_Template - template_neg;

Digit_Templates = zeros(template_w/8, template_h/8, 9, 10);
Digit_Templates(:, :, :, 1) = Digit0_Template;
Digit_Templates(:, :, :, 2) = Digit1_Template;
Digit_Templates(:, :, :, 3) = Digit2_Template;
Digit_Templates(:, :, :, 4) = Digit3_Template;
Digit_Templates(:, :, :, 5) = Digit4_Template;
Digit_Templates(:, :, :, 6) = Digit5_Template;
Digit_Templates(:, :, :, 7) = Digit6_Template;
Digit_Templates(:, :, :, 8) = Digit7_Template;
Digit_Templates(:, :, :, 9) = Digit8_Template;
Digit_Templates(:, :, :, 10) = Digit9_Template;

template_w = 64;
template_h = 96;

% FIX THE TEMPLATE_W & TEMPLATE_H ISSUES

Itest= im2double(rgb2gray(imread('test1.jpg')));

% find ndet top detections in Itest
ndet = 5;
% find ndet_perscale top detections at each scale
ndet_perscale = 5;

% Store, x-coordinate, y-coordinate, width, height, score, scale, and label of
% top ndet detections for each digit.

all_x = [];
all_y = [];
all_scores = [];
all_scales = [];
all_labels = [];

% Detect digits 0-9. 
for r = 1 : 10

    template = Digit_Templates(:, :, :, r);

    %Digit_Template_Visual = hogdraw(template);
    %f1 = figure;
    %imshow(Digit_Template_Visual);

    current_scale = 4.0;
    resize_factor = 0.95;

    Itest_current = imresize(Itest, current_scale);
    computing = size(Itest_current, 1) > (size(template, 1) * 8) & size(Itest_current, 2) > (size(template, 2) * 8);
    
    while computing
       [x,y,score] = detect(Itest_current, template, ndet_perscale); 
       
       x = x ./ current_scale;
       y = y ./ current_scale;
       
       saved_x = [];
       saved_y = [];
       saved_score = [];
       saved_scale = [];
       saved_label = [];
       
       for z = 1:size(score, 2)
          xpixel = x(z);
          ypixel = y(z);
          %disp('xpixel:');
          %disp(xpixel);
          %disp('ypixel:');
          %disp(ypixel);
          s = score(z);
          sc = current_scale;
          
          all_x2 = all_x;
          all_y2 = all_y;
          all_scores2 = all_scores;
          all_scales2 = all_scales;
          all_labels2 = all_labels;
       
          num_values_removed = 0;
          
          overlap = 0; % false
          save = 1; % true
          % if current detection overlaps with any existing detections
          % save the one with higher score
          for p = 1:size(all_scores2, 2)
              %disp('all_x2(p):');
              %disp(all_x2(p));
              %disp('all_y2(p):');
              %disp(all_y2(p));
              if all_x2(p) > xpixel
                condx = (all_x2(p) - xpixel) < template_w/current_scale;
              else
                condx = (xpixel - all_x2(p)) < template_w/all_scales2(p);
              end
              
              if all_y2(p) > ypixel
                condy = (all_y2(p) - ypixel) < template_h/current_scale;
              else
                condy = (ypixel - all_y2(p)) < template_h/all_scales2(p);
              end
              overlap = condx & condy;
              %disp('overlap:')
              %disp(overlap)
              if overlap 
                  if s > all_scores2(p)
                      all_x(p - num_values_removed) = [];
                      all_y(p - num_values_removed) = [];
                      all_scores(p - num_values_removed) = [];
                      all_scales(p - num_values_removed) = [];
                      all_labels(p - num_values_removed) = [];
                      num_values_removed = num_values_removed + 1;
                  else
                      save = 0;
                  end
              end
              %disp('all_x:');
              %disp(all_x);
              %disp('all_y:');
              %disp(all_y);
          end
          %disp('save:');
          %disp(save);
          if save
              saved_x = cat(2, saved_x, xpixel);
              saved_y = cat(2, saved_y, ypixel);
              saved_score = cat(2, saved_score, s);
              saved_scale = cat(2, saved_scale, sc);
              saved_label = cat(2, saved_label, r-1);
          end
       end
       
       
       %disp('saved_x:');
       %disp(saved_x);
       %disp('saved_y:');
       %disp(saved_y);
       
       all_x = cat(2, all_x, saved_x);
       all_y = cat(2, all_y, saved_y);
       all_scores = cat(2, all_scores, saved_score);
       all_scales = cat(2, all_scales, saved_scale);
       all_labels = cat(2, all_labels, saved_label);
       
       %disp('all_x:');
       %disp(all_x);
       %disp('all_y:');
       %disp(all_y);
       
       Itest_current = imresize(Itest_current, resize_factor);
       current_scale = current_scale * resize_factor;
       computing = size(Itest_current, 1) > (size(template, 1) * 8) & size(Itest_current, 2) > (size(template, 2) * 8);
    end
    
    %{
    all_scores2 = all_scores;
    all_x2 = all_x;
    all_y2 = all_y;
    all_scales2 = all_scales;
    all_labels2 = all_labels;
    
    % Remove relatively low scores.
    
    num_values_removed = 0;
    for z = 1:size(all_scores2, 2)
        disp('Iteration:')
        disp(z);
        disp('Current Score:')
        disp(all_scores2(z));
        if all_scores2(z) < 0.5 * max(all_scores2)
            disp('Deleted a poor score.');
            all_scores(z - num_values_removed) = [];
            all_x(z - num_values_removed) = [];
            all_y(z - num_values_removed) = [];
            all_scales(z - num_values_removed) = [];
            num_values_removed = num_values_removed + 1;
        end
    end
    %}
    
    %display top ndet detections from all scales
    
    %{
    figure(3); clf; imshow(Itest);
    for i = 1:ndet
      % draw a rectangle.  use color to encode confidence of detection
      % top scoring are green, fading to red
      hold on; 
      h = rectangle('Position',[x(i)- (template_w/(scale(i) * 2)) y(i)- (template_h / (2 * scale(i))) template_w/scale(i) template_h/scale(i)],'EdgeColor',[(1 - (scores(i)/max(scores))) (scores(i)/max(scores))  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
      hold off;
    end
    %}
end 

% Remove any detections whose scale is significantly different from
% the mode of all detection scales.

all_scores2 = all_scores;
all_x2 = all_x;
all_y2 = all_y;
all_scales2 = all_scales;
all_labels2 = all_labels;

avg_scale = mean(all_scales);
num_values_removed = 0;
for i = 1:size(all_scales2, 2)
    disp(all_scales2(i));
    if (all_scales2(i) < 0.5 * avg_scale) || (all_scales2(i) > 2 * avg_scale)
        all_scores(i - num_values_removed) = [];
        all_x(i - num_values_removed) = [];
        all_y(i - num_values_removed) = [];
        all_scales(i - num_values_removed) = [];
        all_labels(i - num_values_removed) = [];
        num_values_removed = num_values_removed + 1;
    end
end

[val, ind] = sort(all_x(:),'ascend');
scores = val(1:size(all_scores, 2));
x = [];
y = [];
scale = [];
label = []

x_coord = zeros(1, 10);
y_coord = zeros(1, 10);
width = zeros(1, 10);
height = zeros(1, 10);

for i = 1:size(all_scores, 2)
    x(i) = all_x(ind(i));
    y(i) = all_y(ind(i));
    scale(i) = all_scales(ind(i));
    label(i) = all_labels(ind(i));

    x_coord(i) = x(i)- (template_w/(scale(i) * 2));
    y_coord(i) = y(i)- (template_h / (2 * scale(i)));
    width(i) = template_w/scale(i);
    height(i) = template_h/scale(i);
    
    %disp(x_coord);
    %disp(y_coord);
    %disp(width);
    %disp(height);

    if x_coord(i) <= 0
        x_coord(i) = 1;
    end
    if y_coord(i) <= 0
        y_coord(i) = 1;
    end;
    if y_coord(i) + height(i) > size(Itest, 1)
        height(i) = size(Itest, 1) - y_coord(i);
    end
    if x_coord(i) + width(i) > size(Itest, 2)
        width(i) = size(Itest, 2) - x_coord(i);
    end

    figure(i);
    imshow(Itest(y_coord(i):y_coord(i) + height(i), x_coord(i):x_coord(i) + width(i)));
end

disp('Zip Code:');
disp(label);

% All digits have been detected correctly in each of 5 test images.
% However, some digits have been misclassified.
% Attempt to use a classification algorithm to correct the result.

% PART 2: Digit classification with kNN (practice)

%Construct a K NN-classifier that computes the K closest training images, 
%and returns the most common label from this set. Experiment with K = 1,3,5.
%What is the best-performing K? Display its class-confusion matrix and report 
%the average missclassificaiton rate. [15pt]

K = 5;
num_test_samples = 5;
num_training_samples = 5000;
predicted_K_labels = zeros(K, 1);
predicted_labels = zeros(num_test_samples, 1);

distance_array = zeros(1, num_training_samples);

for y = 1: num_test_samples
    %Extract a test image
    test_image = Itest(y_coord(y):y_coord(y) + height(y), x_coord(y):x_coord(y) + width(y));
    % MNIST images are white on black background
    % We want our test_images to emulate this
    % Therefore, we will invert the pixel values
    test_image = (test_image .* -1) + 1;
    test_image = imresize(test_image, [28 28]);
    bright_value_indeces = find(test_image > 0.18);
    test_image(bright_value_indeces) = 1;
    %figure(y);
    %imshow(test_image);
    test_image = reshape(test_image, [784 1]);
    %Evaluate euclidean distance from test image to 10,000 training images
    for x = 1 : num_training_samples
        dist = pdist2((train_images(:, x))', (test_image)');
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

disp(predicted_labels);

