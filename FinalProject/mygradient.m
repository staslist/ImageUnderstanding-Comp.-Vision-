function [mag,ori] = mygradient(I)
    
    % compute image gradient magnitude and orientation at each pixel
    
    hderivative_filter = [1, -1];
    vderivative_filter = [1, -1]';

    dx = imfilter(I, hderivative_filter, 'same');
    dy = imfilter(I, vderivative_filter, 'same');

    %As_hderiv = conv2(A_smooth, hderivative_filter, 'same');
    %As_vderiv = conv2(A_smooth, vderivative_filter, 'same');

    mag = sqrt(dx.^2 + dy.^2);
    ori = atan(dy ./ dx);

    %f6 = figure
    %imshow(mag)
    %f7 = figure
    %imshow(ori)
    
end
