function CNMHeat
%Nur Iman Nazirah Binti Nasir
clc
xO=0;
xL=1;
tO=0;
tL=1;
%subordinates
n=4;      %n - mesh for x (in matrices for column,j)
m=24;       %m - mesh for y (in matrices for row,i )
dx=(xL-xO)/(n+1);
dt=(tL-tO)/(m+1);
%alpha^2
a2=1;
r=(a2*dt)/dx^2;


%%
%Matrix A
%to construct diagonal of matrix
for i=1:n
    A(i,i)=2*(1+r);
end
for i=1:n-1 
    %to consturct lower and upper triangular    
    A(i,i+1)= -r;
    A(i+1,i)=-r;
end
fprintf('Matrix A:\n');A

%%
%Matrix B
%to construct diagonal of matrix
for i=1:n
    B(i,i)=2*(1-r);
end
for i=1:n-1 
    %to consturct lower and upper triangular    
    B(i,i+1)= r;
    B(i+1,i)=r;
end
fprintf('Matrix B:\n');B

%%
%set up BC's (INSERT EQUATION FOR BOUNDARY EQUATIONS)
x=linspace(xO,xL,n+2);
t=linspace(tO,tL,m+2);
tle=@(x,t)0;
tr=@(x,t)0;
tso=@(x,t)sin(pi*x);
% 1-2*abs(x-0.5)

%%
%Matrix     p
%Matrix p is the the boundary condition in the form of matrix

p = zeros(m+2,n+2);
for j=1:n+2
    p(1,j) = tso(x(1,j),t(1,1));
     p(i,1) = tle(x(1,1),t(1,i));
end   

for i=1:m+2
    p(i,n+2) = tr(x(1,n+2),t(1,i));
end
fprintf('The boundary conditions given in the form of matrix p:\n');p

%%
%Matrix B
 b = zeros(n,1);
     
 for j=1:n
 b(j,1) = tso(x(1,j+1),t(1,1));
 end
 fprintf('The boundary conditions given when k=0:\n');b
 
%%
%declaration of new b
bnew=b;
fprintf('RESULTS:\n\n');
for j=1:m+1
bnew=inv(A)*B*bnew;
col= bnew.'  ;
RESULT=array2table(col); 
fprintf('k =%3d \t u= %.5f\t\t%.5f\t\t%.5f\t\t%.5f \n',j, col);

end
end







 
