%Stanislav Listopad
%CS 216 Spring/Summer 2017

% Part 3: Filter Distributions

A = rgb2gray(imread('zebra_small.jpg')); 
A = im2double(A);

%f = figure
%imshow(A)
S = size(A);

zebra_neck = A(0.15*S(1):0.32*S(1), 0.22*S(2):0.35*S(2), :);
f4 = figure
imshow(zebra_neck)

[hder1, vder1, hder2, vder2, hder4, vder4, csurr1, csurr2] = hw3_part2_filterbanks(zebra_neck, 1);

z_neck_mean_abs_values = zeros(1, 8);
z_neck_mean_abs_values(1, 1) = mean(mean(abs(hder1)));
z_neck_mean_abs_values(1, 2) = mean(mean(abs(vder1)));
z_neck_mean_abs_values(1, 3) = mean(mean(abs(hder2)));
z_neck_mean_abs_values(1, 4) = mean(mean(abs(vder2)));
z_neck_mean_abs_values(1, 5) = mean(mean(abs(hder4)));
z_neck_mean_abs_values(1, 6) = mean(mean(abs(vder4)));
z_neck_mean_abs_values(1, 7) = mean(mean(abs(csurr1)));
z_neck_mean_abs_values(1, 8) = mean(mean(abs(csurr2)));

f1 = figure
bar(z_neck_mean_abs_values)
Labels = {'hder1', 'vder1', 'hder2', 'vder2', 'hder4', 'vder4', 'csurr1', 'csurr2'};
set(gca, 'XTick', 1:8, 'XTickLabel', Labels);


tree_leaves = A(0*S(1):0.17*S(1), 0.32*S(2):0.45*S(2), :);
f5 = figure
imshow(tree_leaves)

[hder1, vder1, hder2, vder2, hder4, vder4, csurr1, csurr2] = hw3_part2_filterbanks(tree_leaves, 0);

t_leaves_mean_abs_values = zeros(1, 8);
t_leaves_mean_abs_values(1, 1) = mean(mean(abs(hder1)));
t_leaves_mean_abs_values(1, 2) = mean(mean(abs(vder1)));
t_leaves_mean_abs_values(1, 3) = mean(mean(abs(hder2)));
t_leaves_mean_abs_values(1, 4) = mean(mean(abs(vder2)));
t_leaves_mean_abs_values(1, 5) = mean(mean(abs(hder4)));
t_leaves_mean_abs_values(1, 6) = mean(mean(abs(vder4)));
t_leaves_mean_abs_values(1, 7) = mean(mean(abs(csurr1)));
t_leaves_mean_abs_values(1, 8) = mean(mean(abs(csurr2)));

f2 = figure
bar(t_leaves_mean_abs_values)
Labels = {'hder1', 'vder1', 'hder2', 'vder2', 'hder4', 'vder4', 'csurr1', 'csurr2'};
set(gca, 'XTick', 1:8, 'XTickLabel', Labels);

grass = A(0.83*S(1):S(1), 0.45*S(2):0.58*S(2), :);
f6 = figure
imshow(grass)

[hder1, vder1, hder2, vder2, hder4, vder4, csurr1, csurr2] = hw3_part2_filterbanks(grass, 0);

grass_mean_abs_values = zeros(1, 8);
grass_mean_abs_values(1, 1) = mean(mean(abs(hder1)));
grass_mean_abs_values(1, 2) = mean(mean(abs(vder1)));
grass_mean_abs_values(1, 3) = mean(mean(abs(hder2)));
grass_mean_abs_values(1, 4) = mean(mean(abs(vder2)));
grass_mean_abs_values(1, 5) = mean(mean(abs(hder4)));
grass_mean_abs_values(1, 6) = mean(mean(abs(vder4)));
grass_mean_abs_values(1, 7) = mean(mean(abs(csurr1)));
grass_mean_abs_values(1, 8) = mean(mean(abs(csurr2)));

f3 = figure
bar(grass_mean_abs_values)
Labels = {'hder1', 'vder1', 'hder2', 'vder2', 'hder4', 'vder4', 'csurr1', 'csurr2'};
set(gca, 'XTick', 1:8, 'XTickLabel', Labels);

