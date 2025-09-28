a=5;
b=10;
s=a+b;
q=a/b;
d=a-b;
p=a*b;
c=a^2;
r=a^(2/3);
sq=sqrt(a);

clc
a=1+i
b=2+3i
s=a+b;
q=a/b;
d=a-b;
p=a*b;
c=a^2;
r=a^(2/3);
sq=sqrt(a);
theta = angle(a)
rho = abs(a)
Re = real(a)
Im = imag(a)
bara = conj(a)




V = zeros(1,4)
V(1) = 1
V(2) = 2
V(3) = 3
V(4) = 4
V(5) = 5
V(6) = 6
z = zeros(1,8)
V = [1+1i,2+3i,3,4]
transpV = transpose(V)
Vect1 = [1, 2, 3, 4];
Vect2 = [5, 6, 7, 8];
S = Vect1 + Vect2
D = Vect1-Vect2
P = Vect1*transpose(Vect2)
PP = Vect1.*Vect2
a = 1;
b = 15;
pas = 2;
V = a:pas:b
v=a:b
l = length(V)
[maxV, indmax] = max(V)
[minV, indmin] = min(V)
ind = find(V == 3)
n = 3;
m = 4;
A = zeros(n,m);
A = [1,2,3,4; 5,6,7,8; 9, 10, 11, 12]
A(2,:)
A(:,3)
A(:,2:end)
A(2:end,1:2:end)
n = 2;
m = 2;
A = zeros(n,m);
A = [4,1; -4, 1]
det(A)
h=trace(A)
inv(A)
transpose(A)
A = [4,1; -4, 1]
B = [1,2; 2, 1]
A + B
A*B
x = 2;
cond1 = (x > 1)
cond2 = (x == 0)
cond3 = (x ~= 0)
cond4 = (x < 5)
cond5=(x<0)
cond6=(x==1)
cond5 = cond1 && cond4
cond6 = cond1 || cond4


x=1;
while x<10
x = x+1;
end
x

for x=1:2:9
result=x
end


low = 0;
high = 0;
for x=1:30
if (x<5)
low=low+1;
else
high = high + 1;
end
end
low
high


dayNumber = input('Enter a number (1 to 7) to get the day of the week: ');

switch dayNumber
    case 1
        disp('Sunday');
    case 2
        disp('Monday');
    case 3
        disp('Tuesday');
    case 4
        disp('Wednesday');
    case 5
        disp('Thursday');
    case 6
        disp('Friday');
    case 7
        disp('Saturday');
    otherwise
        disp('Invalid input. Please enter a number between 1 and 7.');
end




x = 0:0.01:2*pi;
y = cos(x);
figure
plot(x,y)
xlabel('temps')
ylabel('signal')
title('cosinus')

figure(1)
hold on
z = sin(x)
plot(x,z , '.-r')
legend('cosinus', 'sinus')
title('cosinus et sinus')
x = 0:0.01:2*pi;
y = cos(x);
z = sin(x);
figure
subplot(2,1,1)
plot(x,y,'b')
grid on
xlabel('temps')
ylabel('signal')
title('cosinus')
subplot(2,1,2)
plot(x,z,'r')
grid on
xlabel('temps')
ylabel('signal')
title('sinus')




