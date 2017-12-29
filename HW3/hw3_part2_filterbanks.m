%Stanislav Listopad
%CS 216 Spring/Summer 2017

% Part 2: Filterbanks
function [hder1, vder1, hder2, vder2, hder4, vder4, csurr1, csurr2] = hw3_part2_filterbanks(image, disp_images)
    A = image;

    hderivative_filter = [1, -1];
    vderivative_filter = [1, -1]';

    A_smooth1 = imgaussfilt(A,1);

    As_hderiv1 = conv2(A_smooth1, hderivative_filter, 'same');
    hder1 = As_hderiv1;
    As_vderiv1 = conv2(A_smooth1, vderivative_filter, 'same');
    vder1 = As_vderiv1;

    A_smooth2 = imgaussfilt(A,2);

    As_hderiv2 = conv2(A_smooth2, hderivative_filter, 'same');
    hder2 = As_hderiv2;
    As_vderiv2 = conv2(A_smooth2, vderivative_filter, 'same');
    vder2 = As_vderiv2;

    A_smooth3 = imgaussfilt(A,4);

    As_hderiv3 = conv2(A_smooth3, hderivative_filter, 'same');
    hder4 = As_hderiv3;
    As_vderiv3 = conv2(A_smooth3, vderivative_filter, 'same');
    vder4 = As_vderiv3;

    % convolution is distributive
    A_center_surround1 = A_smooth2 - A_smooth1;
    csurr1 = A_center_surround1;
    A_center_surround2 = A_smooth3 - A_smooth2;
    csurr2 = A_center_surround2;

    %{
    f = figure
    imshow(A_smooth1)
    f = figure
    imshow(A_smooth2)
    f = figure
    imshow(A_smooth3)
    %}

    if disp_images
        f1 = figure
        imagesc(As_hderiv1)
        colormap gray;

        f2 = figure
        imagesc(As_vderiv1)
        colormap gray;

        f3 = figure
        imagesc(As_hderiv2)
        colormap gray;

        f4 = figure
        imagesc(As_vderiv2)
        colormap gray;

        f5 = figure
        imagesc(As_hderiv3)
        colormap gray;

        f6 = figure
        imagesc(As_vderiv3)
        colormap gray;

        f7 = figure
        imagesc(A_center_surround1)
        colormap gray;

        f8 = figure
        imagesc(A_center_surround2)
        colormap gray;
    end
end