%Stanislav Listopad
%CS 216 Spring/Summer 2017

% Part 4: Textons

A = rgb2gray(imread('zebra.jpg')); 
A = im2double(A);

S = size(A);

[hder1, vder1, hder2, vder2, hder4, vder4, csurr1, csurr2] = hw3_part2_filterbanks(A, 0);
filterbank = zeros(S(1), S(2), 8);
filterbank(:, :, 1) = hder1;
filterbank(:, :, 2) = vder1;
filterbank(:, :, 3) = hder2;
filterbank(:, :, 4) = vder2;
filterbank(:, :, 5) = hder4;
filterbank(:, :, 6) = vder4;
filterbank(:, :, 7) = csurr1;
filterbank(:, :, 8) = csurr2;

s = size(filterbank);

B = reshape(filterbank, [s(1)*s(2), s(3)]);

[idx, C] = kmeans(B, 20);

idx_reshaped = reshape(idx,[s(1) s(2)]);
figure;
imagesc(idx_reshaped);
colormap jet;
colorbar;