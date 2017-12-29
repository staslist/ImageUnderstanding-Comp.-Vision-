%Stanislav Listopad
%CS 216 Spring/Summer 2017

f = [1, 0, 5, 3]
g = [1, 2]
h = [0, 1, 4]

y1 = xcorr(f, g)
a = xcorr(y1, h)
sum(a)

z1 = xcorr(g, h)
b = xcorr(f, z1)
sum(b)
