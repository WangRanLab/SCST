clear
global d  n
 n=110
d=xlsread('Euc_matrix_normalized.xlsx');
 d=d(1:n,1:n)
x0=(zeros(1,3*n))
 
A0=[];
b0=[];
Aeq=[];
beq=[];
for i=1:n
    lb(i)=0;
    lb(i+n)=0;
    lb(i+2*n)=0;
    
    ub(i)=100;
    ub(i+n)=100;
    ub(i+2*n)=1.0;  
end
 
 x0=(zeros(1,3*n));
 x0(1,2*n)=2.3;
 
options = optimoptions('fmincon',...
    'Algorithm',  'sqp','Display','iter','TolCon',1e-12)
for j=1:5
    
[x,fval]=fmincon(@syFun0,x0,A0,b0,Aeq,beq,lb,ub ,@syCon0 ,options);

x0=x
end
   
 
    for j=1:n;
     A(1,j)=-x(j); 
     A(2,j)=-x(j+n);
     A(3,j)=x(j+2*n)+6.5;
    
    end
A % The optimized coordinates

 for i=1:n
    
    for j=1:n
  D(i,j)=sqrt(( A(1,i)-A(1,j) )^2+( A(2,i)-A(2,j) )^2+( A(3,i)-A(3,j))^2 );
       
    end
     
    end
D   % The Euclidean distance matrix of Opitimal Spatial Distribution
    
   fval