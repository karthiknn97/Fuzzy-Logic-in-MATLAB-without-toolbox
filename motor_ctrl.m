function fo=motor_ctrl(ip1,ip2)
ip=[ip1 ip2] ;
nom=5;                         %Number of output MFs
% Rules
% [ip1 ip2 op weight connection]
R = [1 1 5 1 1
    1 2 5 1 1 
    1 3 5 1 1  
    1 4 5 1 1
    1 5 4 1 1
    2 1 5 1 1
    2 2 5 1 1
    2 3 5 1 1
    2 4 4 1 1
    2 5 3 1 1
    3 1 4 1 1
    3 2 4 1 1
    3 3 3 1 1 
    3 4 2 1 1
    3 5 2 1 1
    4 1 3 1 1
    4 2 2 1 1
    4 3 1 1 1
    4 4 1 1 1
    4 5 1 1 1
    5 1 2 1 1
    5 2 1 1 1 
    5 3 1 1 1
    5 4 1 1 1
    5 5 1 1 1];
omf=zeros(1,nom);

y(1,1)=gausmf(ip(1),[7 30]);
y(1,2)=gausmf(ip(1),[6 15]);
y(1,3)=gausmf(ip(1),[3 0]);
y(1,4)=gausmf(ip(1),[6 -15]);
y(1,5)=gausmf(ip(1),[7 -30]);

y(2,1)=gausmf(ip(2),[7 -30]);
y(2,2)=gausmf(ip(2),[6 -15]);
y(2,3)=gausmf(ip(2),[3 0]);
y(2,4)=gausmf(ip(2),[6 15]);
y(2,5)=gausmf(ip(2),[7 30]);

% Rule evaluation
u=zeros(1,size(R,1));
for i=1:size(R,1)
    if R(i,5)==1
        u(i)=min(y(1,R(i,1)),y(2,R(i,2)))*R(i,4);  % Fuzzy operation OR(max)/AND(min)
    elseif R(i,5)==2
        u(i)=max(y(1,R(i,1)),y(2,R(i,2)))*R(i,4);
    end
end

% Output MFs
omf(1)=-0.02;
omf(2)=-0.01;
omf(3)=0;
omf(4)=0.01;
omf(5)=0.02;

pfo=zeros(1,size(R,1));
for i=1:size(R,1)
    pfo(i)=u(i)*omf(R(i,3));
end
fo=sum(pfo)/sum(u);
end