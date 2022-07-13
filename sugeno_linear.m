function fo=sugeno_linear(ip1,ip2)
ip=[ip1 ip2] ;
nom=5;                         %Number of output MFs
% Rules
% [ip1 ip2 op weight connection]
R = [1 1 1 1 1;   % Rule 1
    1 2 2 1 1;   % Rule 2
    1 3 3 1 1;   % Rule 3
    2 1 2 1 1;   % Rule 4
    2 2 3 1 1;   % Rule 5
    2 3 4 1 1;   % Rule 6
    3 1 3 1 1;   % Rule 7
    3 2 4 1 1;   % Rule 8
    3 3 5 1 1];  % Rule 9    
omf=zeros(1,nom);

y(1,1)=trimf(ip(1),[-20 -10 0]);
y(1,2)=trimf(ip(1),[-10 0 10]);
y(1,3)=trimf(ip(1),[0 10 20]);

y(2,1)=trimf(ip(2),[-20 -10 0]);
y(2,2)=trimf(ip(2),[-10 0 10]);
y(2,3)=trimf(ip(2),[0 10 20]);

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
omf(1)=-20;
omf(2)=-10;
omf(3)=0;
omf(4)=10;
omf(5)=20;

pfo=zeros(1,size(R,1));
for i=1:size(R,1)
    pfo(i)=u(i)*omf(R(i,3));
end
fo=sum(pfo)/sum(u);
end