%Stanislav Listopad
%CS 216 Spring/Summer 2017

%Color quantization using k-means

A = imread('futuristic-city-wallpaper-20.jpg');
A = im2double(A);

s = size(A);
%reshape A into a 2D matrix
B = reshape(A, [s(1)*s(2), s(3)]);
%{
[idx, C] = kmeans(B, 2);

A_quantized = zeros(s);
for i = 1:s(1)
   for j = 1:s(2)
       label = idx((j-1) * s(1) + i);
       A_quantized(i, j, :) = C(label, :);
   end
end

f = figure('name', 'k=2');
imshow(A_quantized)

[idx, C] = kmeans(B, 5);

A_quantized = zeros(s);
for i = 1:s(1)
   for j = 1:s(2)
       label = idx((j-1) * s(1) + i);
       A_quantized(i, j, :) = C(label, :);
   end
end

f2 = figure('name', 'k=5');
imshow(A_quantized)
%}
[idx, C] = kmeans(B, 10);

A_quantized = zeros(s);
for i = 1:s(1)
   for j = 1:s(2)
       label = idx((j-1) * s(1) + i);
       A_quantized(i, j, :) = C(label, :);
   end
end

f3 = figure('name', 'k=10');
imshow(A_quantized)

% scale green values by 1000, perform color quanitization, scale the red
% by 1/1000, display

A_scaled = zeros(size(A));
A_scaled(:, :, 1) = A(:, :, 1) .* 1000;
A_scaled(:, :, 2) = A(:, :, 2);
A_scaled(:, :, 3) = A(:, :, 3);

disp(A_scaled(1, 1, 1));

s = size(A_scaled);
%reshape A into a 2D matrix
B = reshape(A_scaled, [s(1)*s(2), s(3)]);

[idx, C_scaled] = kmeans(B, 10);

A_quantized = zeros(s);
for i = 1:s(1)
   for j = 1:s(2)
       label = idx((j-1) * s(1) + i);
       A_quantized(i, j, :) = C_scaled(label, :);
   end
end

A_quantized(:, :, 1) = A_quantized(:, :, 1) ./ 1000;
f3 = figure('name', 'k=10, red scaled by 1000');
imshow(A_quantized)

