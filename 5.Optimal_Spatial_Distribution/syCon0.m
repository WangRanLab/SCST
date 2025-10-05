function [C,Ceq] =syCon0(x)
% Constraints

global d  n
 
 for i=1:n
 a(i)=x(i);
 b(i)=x(i+n);
 c(i)=x(i+2*n);

 end

for j=1:n
 C(j)=-(a(j)^2+ b(j)^2)+2;
 C(j+n)=(a(j)^2+ b(j)^2)-9.68;
 
end
 
Ceq=[]; 
end