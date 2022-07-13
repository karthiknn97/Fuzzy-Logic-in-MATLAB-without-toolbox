ip=[0 0] ;
points=250;
n1=5;   %Number of input1 MFs
n2=5;   %Number of input2 MFs
r1=[-30 30];      %Range of input1
r2=[-30 30];      %Range of input2

g1=ones(n1,points);
g2=ones(n2,points);

x1=linspace(r1(1),r1(2),points);
x2=linspace(r2(1),r2(2),points);

% Input1 MFs
for i=1:length(x1)
    g1(1,i)=gausmf(x1(i),[7 -30]);
    g1(2,i)=gausmf(x1(i),[6 -15]); 
    g1(3,i)=gausmf(x1(i),[3 0]);
    g1(4,i)=gausmf(x1(i),[6 15]);
    g1(5,i)=gausmf(x1(i),[7 30]);
end
% Input2 MFs
for i=1:length(x2)  
    g2(1,i)=gausmf(x1(i),[7 -30]);
    g2(2,i)=gausmf(x1(i),[6 -15]); 
    g2(3,i)=gausmf(x1(i),[3 0]);
    g2(4,i)=gausmf(x1(i),[6 15]);
    g2(5,i)=gausmf(x1(i),[7 30]);
end

% Plotting
subplot(211);hold on;
for i=1:n1
    plot(x1,g1(i,:)); 
end
ylim([0 1.2]);title('Input 1');line([ip(1) ip(1)],[0 1.1],'Color','k');text(ip(1)+0.1,1,num2str(ip(1)));legend;hold off;
subplot(212);hold on;
for i=1:n2
    plot(x2,g2(i,:)); 
end
ylim([0 1.2]);title('Input 2');line([ip(2) ip(2)],[0 1.1],'Color','k');text(ip(2)+0.1,1,num2str(ip(2)));legend;hold off;