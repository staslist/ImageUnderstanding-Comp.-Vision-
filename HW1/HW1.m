x = randperm(5);
disp(x);

a = [1 2 3;4 5 6;7 8 9];
b = a(2,:);
disp(a);
disp(b);

f = [1501:2000]; 
g = find(f > 1850); 
h = f(g);

x = 22.*ones(1,10);
y = sum(x);

a = [1:100]; 
b = a([end:-1:1]);