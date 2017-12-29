%Stanislav Listopad
%CS 216 Spring/Summer 2017

%PART5_A
%{
a = zeros(1, 100)
a(51) = 1
b = fft(a)
c = conj(b)
d = b.*c
magnitudes = sqrt(d)
magnitudes = fftshift(magnitudes)

s = size(magnitudes)
t = 1 : s(2)
f1 = figure
plot(t, magnitudes)

%PART5_B
a = zeros(1, 100)
a(51) = 1
a(49) = 1
a(50) = 1
a(52) = 1
a(53) = 1
b = fft(a)
c = conj(b)
d = b.*c
magnitudes = sqrt(d)
magnitudes = fftshift(magnitudes)

s = size(magnitudes)
t = 1 : s(2)
f2 = figure
plot(t, magnitudes)
%}
%{
%PART5_C
a = zeros(1, 100)
a(51) = 1
a(49) = 1
a(50) = 1
a(52) = 1
a(53) = 1
a(56) = 1
a(48) = 1
a(54) = 1
a(55) = 1
a(47) = 1
b = fft(a)
c = conj(b)
d = b.*c
magnitudes = sqrt(d)
magnitudes = fftshift(magnitudes)

s = size(magnitudes)
t = 1 : s(2)
f3 = figure
plot(t, magnitudes)

%PART5_D
x = 1:100
a = normpdf(x,51,1)
b = fft(a)
c = conj(b)
d = b.*c
magnitudes = sqrt(d)
magnitudes = fftshift(magnitudes)

s = size(magnitudes)
t = 1 : s(2)
f4 = figure
plot(t, magnitudes)
%}

%PART5_E
%{
x = linspace(-50, 50)
a = normpdf(x,51,2)
b = fft(a)
c = conj(b)
d = b.*c
magnitudes = sqrt(d)
magnitudes = fftshift(magnitudes)

t = linspace(-pi, pi)
f5 = figure
plot(t, magnitudes)
%}


%2D DFT
%Convert to frequency domain. Modify the image's DFT. Convert back to
%spatial domain. Examine. 

A = rgb2gray(imread('future_city_night.jpg')); %if the image is color
A = im2double(A); %convert to double.
F = fftshift(fft2(A));
F_magnitude = abs(F);
F_angle = angle(F);
%f1 = figure;
%imagesc(log(abs(F)))


Z = size(F);
F_MOD = F;
%Set all values outside of the center to zero
for row = 1 : Z(1)
    if row < 0.25*Z(1) || row > 0.75*Z(1)
        F_MOD(row, :) = zeros(1, Z(2));
    else
        for i = 1 : Z(2)
            if i < 0.25*Z(2) || i > 0.75*Z(2)
                F_MOD(row, i) = 0;
            end
        end
    end
end
A_MOD = ifft2(F_MOD);
%imshow(A_MOD);


% Combine magnitude response of one image with phase response of another image

B = rgb2gray(imread('future_city_day.jpg')); %if the image is color
B = im2double(B); %convert to double.

H = fftshift(fft2(B));
H_magnitude = abs(H);
H_angle = angle(H);
%f2 = figure;
%imagesc(log(abs(H)))

abomination = H_magnitude.*exp(1i*F_angle);
abom = ifft2(abomination);
imshow(abom)


%HIGH PASS FILTER

a = zeros(1, 100)
a(49) = 1
a(48) = 1
a(50) = -1
a(51) = -1

x = linspace(-4*pi, 4*pi)
f = cos((pi/6)*x)
result = conv(f, a)

z = size(x)
t = 1 : z(2)
f2 = figure
plot(t, f)

z = size(result)
t = 1 : z(2)
f2 = figure
plot(t, result)

b = fft(a)
c = conj(b)
d = b.*c
magnitudes = sqrt(d)
magnitudes = fftshift(magnitudes)

t = linspace(-pi, pi)
f2 = figure
plot(t, magnitudes)


