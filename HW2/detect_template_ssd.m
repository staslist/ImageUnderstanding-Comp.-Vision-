%Stanislav Listopad
%CS 216 Spring/Summer 2017

A = imread('dilbert1.jpg');
A = im2double(A);
%imshow(A)
%Select letter E
patch = A(52:64,409:419);
patch_size = size(patch)
%imshow(patch)

%flip the image (horizontally & vertically) for correlation via
%convolution
patch_flipped = flipud(fliplr(patch));
f1 = figure
imshow(patch_flipped)
result = conv2(A, patch_flipped, 'same');

Tsquared = sum(sum(patch_flipped.^2))
Isquared = conv2(A.^2, ones(size(patch_flipped)), 'same');
squareddiff = (Isquared - 2*result + Tsquared);
result = squareddiff;
%imagesc(result)

% thresholding
Left = result(2:end-1,2:end-1) < result(1:end-2,2:end-1);
Right = result(2:end-1,2:end-1) < result(3:end,2:end-1);
UpperLeft = result(2:end-1,2:end-1) < result(1:end-2,1:end-2);
UpperMiddle = result(2:end-1,2:end-1) < result(2:end-1,1:end-2);
UpperRight = result(2:end-1,2:end-1) < result(3:end,1:end-2);
BottomLeft = result(2:end-1,2:end-1) < result(1:end-2,3:end);
BottomMiddle = result(2:end-1,2:end-1) < result(2:end-1,3:end);
BottomRight = result(2:end-1,2:end-1) < result(3:end,3:end);
Threshold = result(2:end-1,2:end-1) < 15;
minima = Left & Right & Threshold & UpperLeft & UpperMiddle & UpperRight & BottomLeft & BottomMiddle & BottomRight;

figure;
imshow(A);
hold on;
[patchHeight,patchWidth] = size(patch_flipped);
[y,x] = size(minima);
for i = 1:x
   for j = 1:y
      if minima(j,i) == 1 
          rectangle('Position',[i - patchWidth/2,j - patchHeight/2, patchWidth, patchHeight],'LineWidth',1,'EdgeColor','g');
      end
   end
end
