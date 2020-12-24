% part a
x = [3 1 7 6 4]
y = [10 5 6 2 9]
bar(x,y)

% part b
y = [1 2 3 4; 4 3 2 1]'
x = [11 21 31 41]
bar(x,y)

% part c
x = -5:1:5
y = -x.^2 + 2*x + 3
plot(x,y,'-o')