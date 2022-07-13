function def=fastfuz2op(ip1,ip2)
    ip=[ip1 ip2] ;
    nom=7;          %Number of output MFs
    points=250;                    %Number of points for plotting
    % Rules
    % [ip1 ip2 op weight connection]
    R= [1 6, 5 4 (1) 1
    1 1, 5 4 (1) 1
    1 2, 7 1 (1) 1
    1 3, 7 1 (1) 1
    1 4, 6 2 (1) 1
    1 5, 3 3 (1) 1
    1 7, 3 3 (1) 1
    2 6, 5 4 (1) 1
    2 1, 5 4 (1) 1
    2 2, 7 1 (1) 1
    2 3, 6 2 (1) 1
    2 4, 6 2 (1) 1
    2 5, 3 3 (1) 1
    2 7, 2 3 (1) 1
    3 6, 7 4 (1) 1
    3 1, 7 1 (1) 1
    3 2, 7 2 (1) 1
    3 3, 6 2 (1) 1
    3 4, 3 3 (1) 1
    3 5, 2 6 (1) 1
    3 7, 2 6 (1) 1
    4 6, 7 1 (1) 1
    4 1, 7 1 (1) 1
    4 2, 6 2 (1) 1
    4 3, 3 3 (1) 1
    4 4, 2 6 (1) 1
    4 5, 1 7 (1) 1
    4 7, 1 5 (1) 1
    5 6, 6 1 (1) 1
    5 1, 6 2 (1) 1
    5 2, 3 3 (1) 1
    5 3, 2 6 (1) 1
    5 4, 2 6 (1) 1
    5 5, 1 7 (1) 1
    5 7, 1 5 (1) 1
    6 6, 6 3 (1) 1
    6 1, 3 3 (1) 1
    6 2, 2 6 (1) 1
    6 3, 1 6 (1) 1
    6 4, 1 7 (1) 1
    6 5, 1 5 (1) 1
    6 7, 4 5 (1) 1
    7 6, 3 3 (1) 1
    7 1, 3 3 (1) 1
    7 2, 1 6 (1) 1
    7 3, 1 7 (1) 1
    7 4, 1 7 (1) 1
    7 5, 4 5 (1) 1
    7 7, 4 5 (1) 1];
    xo = linspace(-1,1,points);       %write op range
    omf = zeros(nom,points);
    imp = zeros(length(R),points);
    agg = zeros(1,points);
    omf2 = zeros(nom,points);
    imp2 = zeros(length(R),points);
    agg2 = zeros(1,points);

    y(1,1)=trapmf(ip(1),[-1 -1 -1 -0.666]);
    y(1,2)=trimf(ip(1),[-1 -0.666 -0.3333]);
    y(1,3)=trimf(ip(1),[-0.666 -0.3333 0]);
    y(1,4)=trimf(ip(1),[-0.333 0 0.3333]);
    y(1,5)=trimf(ip(1),[-0 0.333 0.6666]);
    y(1,6)=trimf(ip(1),[0.333 0.666 1]);
    y(1,7)=trapmf(ip(1),[0.666 1 1 1]);

    y(2,1)=trimf(ip(2),[-1 -0.666 -0.333]);
    y(2,2)=trimf(ip(2),[-0.666 -0.333 0]);
    y(2,3)=trimf(ip(2),[-0.333 0 0.333]);
    y(2,4)=trimf(ip(2),[0 0.3333 0.6666]);
    y(2,5)=trimf(ip(2),[0.3333 0.6666 1]);
    y(2,6)=trapmf(ip(2),[-1 -1 -1 -0.666]);
    y(2,7)=trapmf(ip(2),[0.666 1 1 1]);

    % Rule evaluation
    u=zeros(1,length(R));
    for i=1:length(R)
        if R(i,6)==1
            u(i)=min(y(1,R(i,1)),y(2,R(i,2)))*R(i,5);  % Fuzzy operation OR(max)/AND(min)    
        elseif R(i,6)==2
            u(i)=max(y(1,R(i,1)),y(2,R(i,2)))*R(i,5);
        end
    end

    % Output MFs
    for i=1:length(xo)
        omf(1,i)=trimf(xo(i),[-1 -0.6666 -0.333]);
        omf(2,i)=trimf(xo(i),[-0.666 -0.333 0]);
        omf(3,i)=trimf(xo(i),[-0.3333 0 0.3333]);
        omf(4,i)=trapmf(xo(i),[-1 -1 -1 -0.666]);
        omf(5,i)=trapmf(xo(i),[0.666 1 1 1]);
        omf(6,i)=trimf(xo(i),[-0 0.333 0.666]);
        omf(7,i)=trimf(xo(i),[0.3333 0.6666 1]);
    end
    
    for i=1:length(xo)
        omf2(1,i)=trimf(xo(i),[-1 -0.6666 -0.333]);
        omf2(2,i)=trimf(xo(i),[-0.666 -0.333 0]);
        omf2(3,i)=trimf(xo(i),[-0.3333 0 0.3333]);
        omf2(4,i)=trapmf(xo(i),[-1 -1 -1 -0.666]);
        omf2(5,i)=trapmf(xo(i),[0.666 1 1 1]);
        omf2(6,i)=trimf(xo(i),[-0 0.333 0.666]);
        omf2(7,i)=trimf(xo(i),[0.3333 0.6666 1]);
    end

    % Implication
    for i=find(u)
        for j=1:points
            imp(i,j) = min(omf(R(i,3),j),u(i));
            imp2(i,j) = min(omf2(R(i,4),j),u(i));
        end
    end


    % Aggregation
    for i=1:points
        agg(1,i) = max(imp(:,i));
        agg2(1,i) = max(imp2(:,i));
    end

    % Defuzzification (Fuzzy to Crisp)
    def = sum(agg(1,:).*xo)/sum(agg(1,:));
    def2 = sum(agg2(1,:).*xo)/sum(agg2(1,:));
    def = [def,def2];
end