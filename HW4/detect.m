function [x,y,score] = detect(I,template,ndet)

    % return top ndet detections found by applying template to the given image.
    %   x,y should contain the coordinates of the detections in the image
    %   score should contain the scores of the detections
    
    %ndet = 5;
    
    x = zeros(ndet, 1);
    y = zeros(ndet, 1);
    
    %I = rgb2gray(imread('test0.jpg')); %if the image is color
    %I = im2double(I); %convert to double.
    
    %f1 = figure;
    %imshow(I);
    %f2 = figure;
    %imshow(I(1:round(size(I, 1)/4), 1:round(size(I, 2)/4)))
    
    %template = f(1:round(size(f, 1)/4), 1:round(size(f, 2)/4), :);
    
    %f1 = figure;
    %imshow(hogdraw(f, [15]));
    
    %f2 = figure;
    %imshow(hogdraw(template, [15]));
    
    % compute the feature map for the image
    f = hog(I);
    
    nori = size(f,3);

    template_flipped = flipud(fliplr(template)); 
    % cross-correlate template with feature map to get a total response
    R = zeros(size(f,1),size(f,2));
    for i = 1:nori
      R = R + conv2(f(:, :, i), template_flipped(:, :, i), 'same');
    end

    % now return locations of the top ndet detections
   
    % sort response from high to low
    [val,ind] = sort(R(:),'descend');
    %R_1D = R(:);
    
    % this is the non-maximum suppression loop.
    % work down the sorted list of responses, 
    %   only add a detection if it doesn't overlap previously selected detections
    %
    i = 1;
    detcount = 1;
    while ((detcount <= ndet) & (i <= length(ind)))
        % convert ind(i) back to (i,j) values to get coordinates of the block
        xblock = ceil(ind(i) ./ size(f, 1));
        yblock = mod(ind(i), size(f, 1));

        assert(val(i)==R(yblock,xblock)); %make sure we did the indexing correctly

        
        % now convert yblock,xblock to pixel coordinates 
        ypixel = yblock * 8;
        xpixel = xblock * 8;
        
        
        % check if this detection overlaps any detections which we've already added to the list
        % (e.g. check to see if the distance between this detection and the other detections
        %   collected in the arrays x,y is less than half the template width/height)
        cond_x = min(abs(xpixel - x)) < size(template, 1);
        cond_y = min(abs(ypixel - y)) < size(template, 2);
        overlap = cond_x & cond_y;
        
        % if no overlap, then add this detection location and score to the list we return
        if (~overlap)
            x(detcount) = xpixel;
            y(detcount) = ypixel;
            score(detcount) = val(i);
            detcount = detcount+1;
        end
        i = i + 1;
    end
end


