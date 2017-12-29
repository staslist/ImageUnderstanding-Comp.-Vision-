% load 5 training images
% user should select 1 positive example in each training image

disp('Please select one positive example in each of the 5 training images.')

Itrain = im2double(rgb2gray(imread('test0.jpg')));

figure(1); clf;
imshow(Itrain);
rect0 = getrect();

f0 = hog(Itrain);

Itrain = im2double(rgb2gray(imread('test1.jpg')));

figure(1); clf;
imshow(Itrain);
rect1 = getrect();

f1 = hog(Itrain);

Itrain = im2double(rgb2gray(imread('test2.jpg')));

figure(1); clf;
imshow(Itrain);
rect2 = getrect();

f2 = hog(Itrain);

Itrain = im2double(rgb2gray(imread('test3.jpg')));

figure(1); clf;
imshow(Itrain);
rect3 = getrect();

f3 = hog(Itrain);

Itrain = im2double(rgb2gray(imread('test4.jpg')));

figure(1); clf;
imshow(Itrain);
rect4 = getrect();

f4 = hog(Itrain);

rect = [rect0'; rect1'; rect2'; rect3'; rect4'];

[template_w, template_h] = average_boxes(rect);

x0 = rect0(1) + template_w/2;
y0 = rect0(2) + template_h/2;

x1 = rect1(1) + template_w/2;
y1 = rect1(2) + template_h/2;

x2 = rect2(1) + template_w/2;
y2 = rect2(2) + template_h/2;

x3 = rect3(1) + template_w/2;
y3 = rect3(2) + template_h/2;

x4 = rect4(1) + template_w/2;
y4 = rect4(2) + template_h/2;

%compute 8x8 block in which the user clicked
blockx0 = round(x0/8);
blocky0 = round(y0/8); 

blockx1 = round(x1/8);
blocky1 = round(y1/8); 

blockx2 = round(x2/8);
blocky2 = round(y2/8); 

blockx3 = round(x3/8);
blocky3 = round(y3/8); 

blockx4 = round(x4/8);
blocky4 = round(y4/8); 

% compute the average template for where the user clicked
template = zeros(template_h / 8, template_w / 8, 9);

if mod(template_w / 8, 2) == 0 & mod(template_h / 8, 2) == 0
    template = template + f0(blocky0+(-((template_h / 16) - 1):(template_h / 16)),blockx0+(-((template_w / 16) - 1):(template_w / 16)),:);
    template = template + f1(blocky1+(-((template_h / 16) - 1):(template_h / 16)),blockx1+(-((template_w / 16) - 1):(template_w / 16)),:); 
    template = template + f2(blocky2+(-((template_h / 16) - 1):(template_h / 16)),blockx2+(-((template_w / 16) - 1):(template_w / 16)),:); 
    template = template + f3(blocky3+(-((template_h / 16) - 1):(template_h / 16)),blockx3+(-((template_w / 16) - 1):(template_w / 16)),:); 
    template = template + f4(blocky4+(-((template_h / 16) - 1):(template_h / 16)),blockx4+(-((template_w / 16) - 1):(template_w / 16)),:); 
elseif mod(template_w / 8, 2) == 0 & mod(template_h / 8, 2) == 1
    template = template + f0(blocky0+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx0+(-((template_w / 16) - 1):((template_w / 16))),:);
    template = template + f1(blocky1+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx1+(-((template_w / 16) - 1):((template_w / 16))),:); 
    template = template + f2(blocky2+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx2+(-((template_w / 16) - 1):((template_w / 16))),:); 
    template = template + f3(blocky3+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx3+(-((template_w / 16) - 1):((template_w / 16))),:); 
    template = template + f4(blocky4+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx4+(-((template_w / 16) - 1):((template_w / 16))),:); 
elseif mod(template_w / 8, 2) == 1 & mod(template_h / 8, 2) == 0
    template = template + f0(blocky0+(-((template_h / 16) - 1):(template_h / 16)),blockx0+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
    template = template + f1(blocky1+(-((template_h / 16) - 1):(template_h / 16)),blockx1+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
    template = template + f2(blocky2+(-((template_h / 16) - 1):(template_h / 16)),blockx2+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
    template = template + f3(blocky3+(-((template_h / 16) - 1):(template_h / 16)),blockx3+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
    template = template + f4(blocky4+(-((template_h / 16) - 1):(template_h / 16)),blockx4+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
else
    template = template + f0(blocky0+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx0+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
    template = template + f1(blocky1+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx1+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
    template = template + f2(blocky2+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx2+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
    template = template + f3(blocky3+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx3+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
    template = template + f4(blocky4+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),blockx4+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:);
end

template = template/5;

% load a training image from which to create N negative examples

Inegtrain = im2double(rgb2gray(imread('myfile.jpg')));

f = hog(Inegtrain);

template_neg = zeros(template_h / 8, template_w / 8, 9);

% Calculate how many times the template fits (without overlapping) into the
% negative training image.

rows = size(Inegtrain, 1) / template_h;
rows = rows - 1;
columns = size(Inegtrain, 2) / template_w;
columns = columns - 1;

for i = 1:rows
    for j = 1:columns
        if mod(template_w / 8, 2) == 0 & mod(template_h / 8, 2) == 0
            template_neg = template_neg + f((template_h / 16) + (i-1)*(template_h/8)+(-((template_h / 16) - 1):(template_h / 16)),(template_w / 16) + (j-1)*(template_w/8)+(-((template_w / 16) - 1):(template_w / 16)),:); 
        elseif mod(template_w / 8, 2) == 0 & mod(template_h / 8, 2) == 1
            template_neg = template_neg + f(ceil(template_h / 16) + (i-1)*(template_h/8)+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),(template_w / 16) + (j-1)*(template_w/8)+(-((template_w / 16) - 1):((template_w / 16))),:); 
        elseif mod(template_w / 8, 2) == 1 & mod(template_h / 8, 2) == 0
            template_neg = template_neg + f((template_h / 16) + (i-1)*(template_h/8)+(-((template_h / 16) - 1):(template_h / 16)),ceil(template_w / 16) + (j-1)*(template_w/8)+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:); 
        else
            template_neg = template_neg + f(ceil(template_h / 16) + (i-1)*(template_h/8)+(-ceil((template_h / 16) - 1):ceil((template_h / 16) - 1)),ceil(template_w / 16) + (j-1)*(template_w/8)+(-ceil((template_w / 16) - 1):ceil((template_w / 16) - 1)),:); 
        end
    end
end

template_neg = template_neg / (rows*columns);

template = template - template_neg;

%V = hogdraw(template, [15]);
%f = figure;
%imshow(V);

%
% load a test image
%
Itest= im2double(rgb2gray(imread('test5.jpg')));

% find top 5 detections in Itest
ndet = 5;
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


