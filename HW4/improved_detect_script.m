% load a training example image
Itrain = im2double(rgb2gray(imread('test4.jpg')));

%have the user click on some training examples.  
% If there is more than 1 example in the training image (e.g. faces), you could set nclicks higher here and average together
nclick = 1;
figure(1); clf;
imshow(Itrain);
rect = getrect();

[template_w, template_h] = average_boxes(rect');

x = rect(1) + template_w/2;
y = rect(2) + template_h/2;

%compute 8x8 block in which the user clicked
blockx = round(x/8);
blocky = round(y/8); 

assert(mod(template_h, 8) == 0)
assert(mod(template_w, 8) == 0)

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
Itest= im2double(rgb2gray(imread('test4.jpg')));

% find top 3 detections in Itest
ndet = 3;
[x,y,score] = detect(Itest,template,ndet);

%display top ndet detectionsx
figure(3); clf; imshow(Itest);
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)- (template_w / 2) y(i)- (template_h / 2) template_w template_h],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end
