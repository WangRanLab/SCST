function f = syFun0( x )

global d  n

for i=1:n
 a(i)=x(i);
 b(i)=x(i+n);
 c(i)=x(i+2*n);

end

f=0.0;
for i=1:n-1
    for j =i+1:n
 f=f+( sqrt((a(i)-a(j))^2+(b(i)-b(j))^2+(c(i)-c(j))^2)-d(i,j))^2 ;
 
    end
     
end
 
end