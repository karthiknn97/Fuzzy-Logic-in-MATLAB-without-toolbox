function y=trapmf(x,a)
if x<a(1) || x>a(4)
    y=0;
elseif x<a(2)
    y=(x-a(1))/(a(2)-a(1));
elseif x<=a(3)
    y=1;
else 
    y=(a(4)-x)/(a(4)-a(3));
end
end
    