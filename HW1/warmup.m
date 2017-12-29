A = rgb2gray(imread('myfile.jpg')); %if the image is color
A = im2double(A); %convert to double.

%Sort all the intensities in A, put the result in a single 
%10,000-dimensional vector x, and plot the values in x.
B = A(1:100, 1:100);
C = reshape(B, 1, []);
D = sort(C);

Z = size(D);
t = 1:Z(2);
%f1 = figure;
%plot(t, D);

%Display a figure showing a histogram of A's intensities 
%with 32 bins using the hist function.

%f2 = figure;
%hist(D, 32);

%Create and display a new binary image the same size as A, which is white 
%wherever the intensity in A is greater than a threshold t, and black everywhere else.
%f3 = figure;
%imshow(A);
A_MOD = A;
threshold = 0.2;
for idx = 1:numel(A_MOD)
    element = A_MOD(idx);
    if element > threshold
        A_MOD(idx) = 1.0;
    else
        A_MOD(idx) = 0.0;
    end
end
%f4 = figure;
%imshow(A_MOD);

%Display the bottom right quadrant of A.
Z = size(A);
A_RIGHT_QUADRANT = A(0.5*Z(1):Z(1), 0.5*Z(2):Z(2));
%f5 = figure;
%imshow(A_RIGHT_QUADRANT);

%Generate a new image (matrix), which is the same as A, but with A's mean 
%intensity value subtracted from each pixel. Set any negative values to 0.
A_MOD = A;
A_mean_1 = mean(A);
A_mean_2 = mean(A_mean_1);
for idx = 1:numel(A_MOD)
    element = A_MOD(idx);
    if (element - A_mean_2) > 0
        A_MOD(idx) = element - A_mean_2;
    else
        A_MOD(idx) = 0.0;
    end
end
%f6 = figure;
%imshow(A_MOD);

%Display the mirror-flipped version of image A. That is, if A was an image 
%of right-facing car, transform A to be a left-facing car.
A_MOD = A;
for row = 1 : Z(1)
    a = A_MOD(row, :);
    A_MOD(row, :) = a([end:-1:1]);
end
%f7 = figure;
%imshow(A_MOD);

%Use the min and find functions to set x to the single minimum value that 
%occurs in A, and set r to the row it occurs in and c to the column it occurs in.
min_value = min(min(A));
[r, c] = find(A == min_value);
r = r(1);
c = c(1);
%disp(min_value);
%disp(r);
%disp(c);

%Let v be the vector: v = [1 8 8 2 1 3 9 8]. Use the unique function to 
%compute the total number of unique values that occur in v.
v = [1 8 8 2 1 3 9 8];
b = unique(v);
c = numel(b);
disp(c);
