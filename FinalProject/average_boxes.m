function [w,h] = average_boxes(boxes)

%
% estimate a good template size for our HOG template
%
% boxes is assumed to be an array of size 4xN
% where where each column encodes the size of an
% example bounding box in pixel coordinates.
% 
%   boxes(:,i) = [xmin ymin width height]
%
%
% the function returns an "average" sized box width and height
%

binsize = 8;  %assume hog bins are 8x8 pixels

% compute the average aspect ratio
aratio = mean(boxes(3,:) ./ boxes(4,:));

% compute the average area (in pixels) of the boxes
area = mean(boxes(3,:).*boxes(4,:));

barea = floor(area / (binsize*binsize)); % area in bins

% now we want to find an H and W in units
% of bins so that 
%
%  W*H = barea
%  W/H = aratio
%
%  H and W are both multiples of binsize
%
%  rearrange first equation
%
%    H = (barea / W)  
%
%  substitute into second equation
%
%    aratio = W/H  =  W / (barea/W) = W*W/barea
%  
%  so:
%
W = sqrt(aratio * barea);
H = W / aratio;

% round to integers and multiply by binsize
% to get template dimension in pixels

w = round(W)*binsize;
h = round(H)*binsize;


