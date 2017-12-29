%Stanislav Listopad
%CS 216 Spring/Summer 2017

A = imread('dilbert1.jpg');
A = im2double(A);
%imshow(A)
%Select letter E
patch = A(52:64,409:419);
patch_size = size(patch)
%imshow(patch)

%Approach 1) non-convolutional

num_detections = 0;
A_size = size(A);
match_matrix = zeros(A_size);
for row = 1 : (A_size(1) - patch_size(1))
    for i = 1 : (A_size(2) - patch_size(2))
        corr_result = corr2(A(row: row + patch_size(1) - 1, i: i + patch_size(2) - 1), patch);
        if corr_result > 0.8
            %disp('Detected the object (letter E) in the image!')
            %disp(corr_result)
            %num_detections = num_detections + 1;
            match_matrix(row, i) = 1;
        end
    end
end
%fprintf('Detected the object (letter E) %d number of times!', num_detections) 

figure;
imshow(A);
hold on;
[patchHeight,patchWidth] = size(patch);
[y,x] = size(match_matrix);
for i = 1:x
   for j = 1:y
      if match_matrix(j,i) == 1 
          rectangle('Position',[i, j, patchWidth, patchHeight],'LineWidth',1,'EdgeColor','g');
      end
   end
end

%Approach 2) convolutional


%flip the image (horizontally & vertically) for correlation via
%convolution
patch_flipped = flipud(fliplr(patch));
f1 = figure
imshow(patch_flipped)
result = conv2(A, patch_flipped, 'same');
%result_x = conv2(patch, patch_flipped, 'same');
%imagesc(result)

% thresholding
Left = result(2:end-1,2:end-1) > result(1:end-2,2:end-1);
Right = result(2:end-1,2:end-1) > result(3:end,2:end-1);
UpperLeft = result(2:end-1,2:end-1) > result(1:end-2,1:end-2);
UpperMiddle = result(2:end-1,2:end-1) > result(2:end-1,1:end-2);
UpperRight = result(2:end-1,2:end-1) > result(3:end,1:end-2);
BottomLeft = result(2:end-1,2:end-1) > result(1:end-2,3:end);
BottomMiddle = result(2:end-1,2:end-1) > result(2:end-1,3:end);
BottomRight = result(2:end-1,2:end-1) > result(3:end,3:end);
Threshold = result(2:end-1,2:end-1) > 80;

% White spaces in the image are made up of pixel values with intensity 1.
% Therefore, correlation between the patch & white space generates the
% highest values. Use threshold2 to filter out 'white space matching'.
Threshold2 = result(2:end-1,2:end-1) < 81;

maxima = Left & Right & Threshold & Threshold2 & UpperLeft & UpperMiddle & UpperRight & BottomLeft & BottomMiddle & BottomRight;

figure;
imshow(A);
hold on;
[patchHeight,patchWidth] = size(patch_flipped);
[y,x] = size(maxima);
for i = 1:x
   for j = 1:y
      if maxima(j,i) == 1 
          rectangle('Position',[i - patchWidth/2,j - patchHeight/2, patchWidth, patchHeight],'LineWidth',1,'EdgeColor','g');
      end
   end
end
