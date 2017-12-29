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
%[x,y] = ginput(nclick); %get nclicks from the user
rect = getrect();

[template_w, template_h] = average_boxes(rect');

x = rect(1) + template_w/2;
y = rect(2) + template_h/2;

%compute 8x8 block in which the user clicked
blockx = round(x/8);
blocky = round(y/8); 

% can set template height and width to any number that is
% 1) template dimensions must be small enough to be successfully 
% extracted from the image. 2) Template height and width must be multiple
% of 8. 3) Template height and width must be positive. 4) Template height &
% width must be bigger or equal to 16 pixels each.

%template_h = 80;
%template_w = 64;

%visualize image patches that the user clicked on
figure(2); clf;
for i = 1:nclick
  patch = Itrain(8*blocky(i)+(-(template_h/2 - 1):(template_h/2)),8*blockx(i)+(-(template_w/2 - 1):(template_w/2)));
  figure(2); subplot(3,2,i); imshow(patch);
end

% compute the hog features
f = hog(Itrain);

% compute the average template for where the user clicked
template = zeros(template_h / 8, template_w / 8, 9);

for i = 1:nclick
    if mod(template_w / 8, 2) == 0 & mod(template_h / 8, 2) == 0
        template = template + f(blocky(i)+(-((template_h / 16) - 1):(template_h / 16)),blockx(i)+(-((template_w / 16) - 1):(template_w / 16)),:); 
    elseif mod(template_w / 8, 2) == 0 & mod(template_h / 8, 2) == 1
        template = template + f(blocky(i)+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx(i)+(-((template_w / 16) - 1):((template_w / 16))),:); 
    elseif mod(template_w / 8, 2) == 1 & mod(template_h / 8, 2) == 0
        template = template + f(blocky(i)+(-((template_h / 16) - 1):(template_h / 16)),blockx(i)+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:); 
    else
        template = template + f(blocky(i)+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx(i)+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:); 
    end
end
template = template/nclick;


%
% load a test image
%
current_scale = 8.0;

Itest= im2double(rgb2gray(imread('stopsigns.jpg')));
Itest_current = imresize(Itest, current_scale);
computing = size(Itest_current, 1) > (size(template, 1) * 8) & size(Itest_current, 2) > (size(template, 2) * 8);

% find top 3 detections in Itest
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
  h = rectangle('Position',[x(i)- (template_w / 2) y(i)- (template_h / 2) template_w template_h],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end