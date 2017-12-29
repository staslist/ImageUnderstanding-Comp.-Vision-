%Stanislav Listopad
%CS 216 Spring/Summer 2017

%multiscale_detect

% load a training example image
Itrain = im2double(rgb2gray(imread('stopsigns.jpg')));

%have the user click on some training examples.  
% If there is more than 1 example in the training image (e.g. faces), you could set nclicks higher here and average together
nclick = 1;
figure(1); clf;
imshow(Itrain);
[x,y] = ginput(nclick); %get nclicks from the user

%compute 8x8 block in which the user clicked
blockx = round(x/8);
blocky = round(y/8); 


%
% the following code assumes the template is 128x128 pixels  
%   (16x16 hog blocks) so you will want to eventually modify
%   it to handle different sized templates.
%

%visualize image patches that the user clicked on
figure(2); clf;
for i = 1:nclick
  patch = Itrain(8*blocky(i)+(-63:64),8*blockx(i)+(-63:64));
  figure(2); subplot(3,2,i); imshow(patch);
end

% compute the hog features
f = hog(Itrain);

% compute the average template for where the user clicked
template = zeros(16,16,9);
for i = 1:nclick
  template = template + f(blocky(i)+(-7:8),blockx(i)+(-7:8),:); 
end
template = template/nclick;


%
% load a test image
%
current_scale = 8.0;

Itest= im2double(rgb2gray(imread('stopsigns.jpg')));
Itest_current = imresize(Itest, current_scale);
computing = size(Itest_current, 1) > (size(template, 1) * 8) & size(Itest_current, 2) > (size(template, 2) * 8);

% find top 5 detections in Itest
ndet = 5;
% find two top detection at each scale
det_perscale = 2;
all_x = [];
all_y = [];
all_scores = [];


while computing
   [x,y,score] = detect(Itest_current,template,det_perscale); 
   all_x = cat(2, all_x, x ./ current_scale);
   all_y = cat(2, all_y, y ./ current_scale);
   all_scores = cat(2, all_scores, score);
   Itest_current = imresize(Itest_current, 0.7);
   current_scale = current_scale * 0.7;
   computing = size(Itest_current, 1) > (size(template, 1) * 8) & size(Itest_current, 2) > (size(template, 2) * 8);
end

[val, ind] = sort(all_scores(:),'descend');
scores = val(1:ndet);
x = [];
y = [];
for i = 1:ndet
    x(i) = all_x(ind(i));
    y(i) = all_y(ind(i));
end

%display top ndet detections from all scales
figure(3); clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)-64 y(i)-64 128 128],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end
