%PART B 1)
%{
Average = zeros(215, 300);

filelist = dir('set2/*.jpg');
x = length(filelist);
      for i=1:x
               imname = ['set2/' filelist(i).name];
               A = rgb2gray(imread(imname)); %if the image is color
               A = im2double(A); %convert to double.
               B = imresize(A, [215, 300]);
               Average = Average + B;
      end
Average = Average / x;
f1 = figure;
imshow(Average);
%}
%PART B 2)


Average = zeros(215, 300, 3);

filelist = dir('set2/*.jpg');
x = length(filelist);
      for i=1:x
               imname = ['set2/' filelist(i).name];
               A = imread(imname); %if the image is color
               A = im2double(A); %convert to double.
               B = imresize(A, [215, 300]);
               Average = Average + B;
      end
Average = Average / x;
f2 = figure;
imshow(Average);


%PART B 3)

Average = zeros(215, 300, 3);

filelist = dir('set2/*.jpg');
x = length(filelist);
      for i=1:x
               imname = ['set2/' filelist(i).name];
               A = imread(imname); %if the image is color
               A = im2double(A); %convert to double.
               B = imresize(A, [215, 300]);
               r = rand();
               if r < 0.5
                   for row = 1 : 215
                       a = B(row, :);
                       B(row, :) = a([end:-1:1]);
                   end
               end
               Average = Average + B;
      end
Average = Average / x;
f3 = figure;
imshow(Average);


