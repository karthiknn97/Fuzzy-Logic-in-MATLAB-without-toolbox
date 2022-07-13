function y=trimf(x,a)
 if x<=a(1)
     y=0;
 elseif x<=a(2)
     y=(x-a(1))/(a(2)-a(1));
 elseif x<=a(3)
     y=(a(3)-x)/(a(3)-a(2));
 else 
     y=0;
end