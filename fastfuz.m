function def=fastfuz(ip1,ip2)
    ip=[ip1 ip2] ;
    nom=7;          %Number of output MFs
    points=250;                    %Number of points for plotting
    % Rules
    % [ip1 ip2 op weight connection]
    R= [1 1, 1 (1) 1
    2 1, 1 (1) 1
    3 1, 1 (1) 1
    4 1, 1 (1) 1
    5 1, 2 (1) 1
    6 1, 3 (1) 1
    7 1, 4 (1) 1
    1 2, 1 (1) 1
    2 2, 1 (1) 1
    3 2, 1 (1) 1
    4 2, 2 (1) 1
    5 2, 3 (1) 1
    6 2, 4 (1) 1
    7 2, 5 (1) 1
    1 3, 1 (1) 1
    2 3, 1 (1) 1
    3 3, 2 (1) 1
    4 3, 3 (1) 1
    5 3, 4 (1) 1
    6 3, 5 (1) 1
    7 3, 6 (1) 1
    1 4, 1 (1) 1
    2 4, 2 (1) 1
    3 4, 3 (1) 1
    4 4, 4 (1) 1
    5 4, 5 (1) 1
    6 4, 6 (1) 1
    7 4, 7 (1) 1
    1 5, 2 (1) 1
    2 5, 3 (1) 1
    3 5, 4 (1) 1
    4 5, 5 (1) 1
    5 5, 6 (1) 1
    6 5, 7 (1) 1
    7 5, 7 (1) 1
    1 6, 3 (1) 1
    2 6, 4 (1) 1
    3 6, 5 (1) 1
    4 6, 6 (1) 1
    5 6, 7 (1) 1
    6 6, 7 (1) 1
    7 6, 7 (1) 1
    1 7, 4 (1) 1
    2 7, 5 (1) 1
    3 7, 6 (1) 1
    4 7, 7 (1) 1
    5 7, 7 (1) 1
    6 7, 7 (1) 1
    7 7, 7 (1) 1];
    xo=linspace(-2,2,points);       %write op range
    omf=zeros(nom,points);
    imp=zeros(length(R),points);
    agg=zeros(1,points);

    y(1,1)=trapmf(ip(1),[-2 -2 -1 -0.7]);
    y(1,2)=trimf(ip(1),[-1 -0.65 -0.3]);
    y(1,3)=trimf(ip(1),[-0.7 -0.35 0]);
    y(1,4)=trimf(ip(1),[-0.2 0 0.2]);
    y(1,5)=trimf(ip(1),[0 0.35 0.7]);
    y(1,6)=trimf(ip(1),[0.3 0.65 1]);
    y(1,7)=trapmf(ip(1),[0.7 1 2 2]);

    y(2,1)=trapmf(ip(2),[-2 -2 -1 -0.7]);
    y(2,2)=trimf(ip(2),[-1 -0.65 -0.3]);
    y(2,3)=trimf(ip(2),[-0.7 -0.35 0]);
    y(2,4)=trimf(ip(2),[-0.3 0 0.3]);
    y(2,5)=trimf(ip(2),[0 0.35 0.7]);
    y(2,6)=trimf(ip(2),[0.3 0.65 1]);
    y(2,7)=trapmf(ip(2),[0.7 1 2 2]);

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
    for i=1:length(xo)
        omf(1,i)=trapmf(xo(i),[-2 -2 -1 -0.7]);
        omf(2,i)=trimf(xo(i),[-1 -0.65 -0.3]);
        omf(3,i)=trimf(xo(i),[-0.7 -0.35 0]);
        omf(4,i)=trimf(xo(i),[-0.2 0 0.2]);
        omf(5,i)=trimf(xo(i),[0 0.35 0.7]);
        omf(6,i)=trimf(xo(i),[0.3 0.65 1]);
        omf(7,i)=trapmf(xo(i),[0.7 1 2 2]);
    end

    % Implication
    for i=find(u)
        for j=1:points
            imp(i,j)=min(omf(R(i,3),j),u(i));
        end
    end

    % Aggregation
    for i=1:points
        agg(1,i)=max(imp(:,i));
    end

    % Defuzzification (Fuzzy to Crisp)
    def=sum(agg(1,:).*xo)/sum(agg(1,:));   
end