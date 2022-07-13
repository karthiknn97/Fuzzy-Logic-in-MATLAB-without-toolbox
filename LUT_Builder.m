n=250;
x=linspace(-30,30,n);
y=zeros(n);
tic 
for i=1:n
    for j=1:n
        y(i,j)=motor_ctrl(x(i),x(j));
    end
end
toc
surf(y);    
