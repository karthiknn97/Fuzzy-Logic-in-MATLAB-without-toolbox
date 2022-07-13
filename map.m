function def=map(ip1,ip2)
    ip=[ip1 ip2] ;
    nom=4;          %Number of output MFs
    points=100;                    %Number of points for plotting
    % Rules
    % [ip1 ip2 op weight connection]
    R= [1 3, 3 (1) 1
    2 3, 2 (1) 1
    3 3, 1 (1) 1
    1 2, 3 (1) 1
    2 2, 3 (1) 1
    3 2, 2 (1) 1
    1 1, 4 (1) 1
    2 1, 3 (1) 1
    3 1, 3 (1) 1];
    xo=linspace(0,10,points);       %write op range
    omf=zeros(nom,points);
    imp=zeros(length(R),points);
    agg=zeros(1,points);

    y(1,1)=traprmf(ip(1),[130 150]);
    y(1,2)=trapmf(ip(1),[130 150 190 210]);
    y(1,3)=traplmf(ip(1),[190 210]);

    y(2,1)=trimf(ip(2),[-20 -10 0]);
    y(2,2)=trimf(ip(2),[-10 0 10]);
    y(2,3)=trimf(ip(2),[0 10 20]);

    % Rule evaluation
    u=zeros(1,length(R));
    for i=1:length(R)
        if R(i,5)==1
            u(i)=min(y(1,R(i,1)),y(2,R(i,2)))*R(i,4);  % Fuzzy operation OR(max)/AND(min)
        elseif R(i,5)==2
            u(i)=max(y(1,R(i,1)),y(2,R(i,2)))*R(i,4);
        end
    end

    % Output MFs
    for i=1:length(xo)
        omf(1,i)=traprmf(xo(i),[2 4]);
        omf(2,i)=trimf(xo(i),[2 4 6]);
        omf(3,i)=trimf(xo(i),[4 6 8]);
        omf(4,i)=traplmf(xo(i),[6 8]);
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