%Stanislav Listopad
%CS 216 Spring/Summer 2017

%Edge Detection

%Smooth out the image using gaussian filter

A = rgb2gray(imread('future_city_night.jpg')); %if the image is color
A = im2double(A); %convert to double.

%Use either approach to smooth the image
%imshow(A)

A_smooth = imgaussfilt(A,1);
f5 = figure
imshow(A_smooth)

%x = 1:100;
%gauss_filter = normpdf(x,50,2);
%A_smooth = conv2(A, gauss_filter, 'same');
%f6 = figure
%imshow(A_smooth)

%Calculate horizontal & vertical derivatives
hderivative_filter = [1, -1];
vderivative_filter = [1, -1]';

As_hderiv = conv2(A_smooth, hderivative_filter, 'same');
As_vderiv = conv2(A_smooth, vderivative_filter, 'same');

%Gradient magnitude
As_gradient_magnitude = sqrt(As_hderiv.^2 + As_vderiv.^2);
As_gradient_orientation = atan(As_vderiv ./ As_hderiv);
f6 = figure
imshow(As_gradient_magnitude)
f7 = figure
imshow(As_gradient_orientation)